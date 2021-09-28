<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrintHistory.ascx.cs"
    Inherits="EMR_PrintHistory" %>

<script type="text/javascript" src="../Scripts/Common.js">

</script>

<script language="javascript" type="text/javascript">
    
</script>

<script language="javascript" type="text/javascript">

    function createFtab() {
        var j = 1;
        var AddStatus = 0;
        var tmpTable;
        var rownumber = 0;
        //Print Surgery History in ViewEMRPackage
        var objHis = document.getElementById('PrintHistory1_hdnSurgeryHis');
        if (objHis != null) {
            var HidValue = document.getElementById('PrintHistory1_hdnSurgeryHis').value.trim();

            if (HidValue != null) {

                var list = HidValue.split('^');
                if (list.length > 1) {
                    itemlist = document.getElementById('PrintHistory1_hdnSurgeryHis').value.split('^');
                    tmpTable = "<table width=38% border='1' cellspacing='0' cellpadding='0'  style = 'border:1;border-color:Gray;'><tr><td style='display: none;background-color:Olive;' CssClass='dataheader1'></td><td colspan=1 align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;' CssClass='dataheader1'><b>Surgery Name</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;'><b>Date</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;'><b>Hospital Name</b></td></tr><tr><td>";

                    for (var i = 0; i < itemlist.length - 1; i++) {
                        var item = itemlist[i].split('~');
                        tmpTable += "<tr><td style='display:none;ba'><img id='imgbtn2'  style='cursor:pointer;' OnClick='ImgClick(" + rownumber + ");'";
                        tmpTable += " src='../Images/Delete.jpg' /></td><td style='display: none;'>";
                        tmpTable += parseInt(rownumber) + "</td><td>" + item[1] + "</td><td>" + item[2] + "</td><td>" + item[3] + "</td><td>";
                        rownumber++;
                    }
                    tmpTable += "</table>";
                    var obj = document.getElementById('PrintHistory1_divSurTable');
                    obj.style.display = "block";
                    obj.innerHTML = tmpTable;
//                    var obj1 = document.getElementById('PrintHistory2_divSurTable');
//                    obj1.style.display = "block";
//                    obj1.innerHTML = tmpTable;
                }
            }
        }

        //Print Family History in ViewEMRPackage
        var obj = document.getElementById('PrintHistory1_hdnFamilyHistory');
        if (obj != null) {
            var HidFValue = document.getElementById('PrintHistory1_hdnFamilyHistory').value.trim();
            if (HidFValue != null) {
                var list = HidFValue.split('^');
                if (list.length > 1) {
                    itemlist = document.getElementById('PrintHistory1_hdnFamilyHistory').value.split('^');
                    tmpTable = "<table width=38% border='1' cellspacing='0' cellpadding='0'  style = 'border:1;border-color:Gray;'><tr><td style='display: none;background-color:Olive;' CssClass='dataheader1'></td><td colspan=1 align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;' CssClass='dataheader1'><b>Relationship</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;'><b>Disorder</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;'><b>Event</b></td></tr><tr><td>";

                    for (var i = 0; i < itemlist.length - 1; i++) {
                        var item = itemlist[i].split('~');
                        tmpTable += "<tr><td style='display:none;ba'><img id='imgbtn2'  style='cursor:pointer;' OnClick='ImgClick(" + rownumber + ");'";
                        tmpTable += " src='../Images/Delete.jpg' /></td><td style='display: none;'>";
                        tmpTable += parseInt(rownumber) + "</td><td>" + item[1] + "</td><td>" + item[2] + "</td><td>" + item[3] + "</td></tr>";
                        rownumber++;
                    }
                    tmpTable += "</table>";
                    var obj = document.getElementById('PrintHistory1_divTable');
                    obj.style.display = "block";
                    obj.innerHTML = tmpTable;
//                    var obj1 = document.getElementById('PrintHistory2_divTable');
//                    obj1.style.display = "block";
//                    obj1.innerHTML = tmpTable;
                }
            }
        }

        return;
    }


    function createFtab_new() {
        // debugger;
        var j = 1;
        var AddStatus = 0;
        var tmpTable;
        var rownumber = 0;
        var d3 = "";
        var Loc = "";
        var d = new Date();
        //Print Surgery History in ViewEMRPackage
        var objHis = document.getElementById('PrintHistory2_hdnSurgeryHis');
        if (objHis != null) {
            var HidValue = document.getElementById('PrintHistory2_hdnSurgeryHis').value.trim();

            if (HidValue != null) {

                var list = HidValue.split('^');
                if (list.length > 1) {
                    itemlist = document.getElementById('PrintHistory2_hdnSurgeryHis').value.split('^');
                    tmpTable = "<table width=68% border='1' cellspacing='0' cellpadding='0'  style = 'border:1;border-color:Gray;'><tr><td style='display: none;background-color:Olive;' CssClass='dataheader1'></td><td colspan=1 align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;' CssClass='dataheader1'><b>Surgery Name</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;'><b>Year</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;' nowrap='nowrap'><b>Hospital Name</b></td></tr><tr><td>";

                    for (var i = 0; i < itemlist.length - 1; i++) {
                        var item = itemlist[i].split('~');
                        tmpTable += "<tr><td style='display:none;ba'><img id='imgbtn2'  style='cursor:pointer;' OnClick='ImgClick(" + rownumber + ");'";
                        tmpTable += " src='../Images/Delete.jpg' /></td><td style='display: none;'>";
                        var d
                        dd = new Date(item[2]);
                        var l = item.length - 1;
                        // alert(l);
                        d3 = dd.getFullYear() == "1999" ? "-" : dd.getFullYear();
                        Loc = item[3] == "" ? "-" : item[3];
                        tmpTable += parseInt(rownumber) + "</td><td>" + item[1] + "</td><td align='center'>" + d3 + "</td><td align='center'>" + Loc + "</td><td>";
                        rownumber++;
                    }
                    tmpTable += "</table>";
                    var obj = document.getElementById('PrintHistory2_divSurTable');
                    obj.style.display = "block";
                    obj.innerHTML = tmpTable;
                    var obj1 = document.getElementById('tcEMR_tpHistory_PrintHistory1_divSurTable');
                    obj1.style.display = "block";
                    obj1.innerHTML = tmpTable;
                }
            }
        }

        //Print Family History in ViewEMRPackage
        var obj = document.getElementById('PrintHistory2_hdnFamilyHistory');
        if (obj != null) {
            var HidFValue = document.getElementById('PrintHistory2_hdnFamilyHistory').value.trim();
            if (HidFValue != null) {
                var list = HidFValue.split('^');
                if (list.length > 1) {
                    itemlist = document.getElementById('PrintHistory2_hdnFamilyHistory').value.split('^');
                    tmpTable = "<table width=48% border='1' cellspacing='0' cellpadding='0'  style = 'border:1;border-color:Gray;'><tr><td style='display: none;background-color:Olive;' CssClass='dataheader1'></td><td colspan=1 align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;' CssClass='dataheader1'><b>Relationship</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;'><b>Disorder</b></td><td align='center' style='background-color:#2c88b1;font-weight: bold; height: 6px; color: #ffffff;'><b>Event</b></td></tr><tr><td>";

                    for (var i = 0; i < itemlist.length - 1; i++) {
                        var item = itemlist[i].split('~');
                        tmpTable += "<tr><td style='display:none;'><img id='imgbtn2'  style='cursor:pointer;' OnClick='ImgClick(" + rownumber + ");'";
                        tmpTable += " src='../Images/Delete.jpg' /></td><td style='display: none;'>";
                        tmpTable += parseInt(rownumber) + "</td><td>" + item[1] + "</td><td>" + item[2] + "</td><td>" + item[3] + "</td></tr>";
                        rownumber++;
                    }
                    tmpTable += "</table>";
                    var obj = document.getElementById('PrintHistory2_divTable');
                    obj.style.display = "block";
                    obj.innerHTML = tmpTable;
                    var obj1 = document.getElementById('tcEMR_tpHistory_PrintHistory1_divTable');
                    obj1.style.display = "block";
                    obj1.innerHTML = tmpTable;
                }
            }
        }

        return;
    }

    
</script>

<table id="tblMedical" runat="server" style="display: none;" width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="Label1" runat="server" Text="MEDICAL HISTORY"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblMedical1" runat="server" style="display: none;" width="100%" cellpadding="0"
    cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trPresent" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblPresent" Visible="false" runat="server" Text="Present Complaints"
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblPresentComplaints" runat="server" Text=""></asp:Label>
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
                <tr id="trSystemic" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblSystemicHypertension_402" runat="server" Text="Systemic Hypertension"
                            Font-Bold="True" meta:resourcekey="lblSystemicHypertension_402Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblShNill" runat="server" Text=" Nil" meta:resourcekey="lblShNillResource1"></asp:Label>
                                    <asp:Label ID="lblDurationShAVI_1" runat="server" Visible="False" meta:resourcekey="lblDurationShAVI_1Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trSystemic1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trHeart" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblHeartDisease_332" runat="server" Text="Heart Disease " Font-Bold="True"
                            meta:resourcekey="lblHeartDisease_332Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" id="tabHeart" style="display: none;" runat="server" cellspacing="0"
                            border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblHDNil" runat="server" Text="Nil" meta:resourcekey="lblHDNilResource1"></asp:Label>
                                    <asp:Label ID="lblDiseaseTypeHDAI_3" runat="server" Text="Disease Type :-" Visible="False"
                                        meta:resourcekey="lblDiseaseTypeHDAI_3Resource1"></asp:Label>
                                    <asp:Label ID="lblDiseaseTypeHDAVI_3" runat="server" Visible="False" meta:resourcekey="lblDiseaseTypeHDAVI_3Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblDiseaseHDAI_4" runat="server" Text="Disease :-" Visible="False"
                                        meta:resourcekey="lblDiseaseHDAI_4Resource1"></asp:Label>
                                    <asp:Label ID="lblDiseaseHDAVI_4" runat="server" Visible="False" meta:resourcekey="lblDiseaseHDAVI_4Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trHeart1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trDiabetes" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblDiabetesMellitus_389" runat="server" Text="Diabetes Mellitus" Font-Bold="True"
                            meta:resourcekey="lblDiabetesMellitus_389Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblDMNil" runat="server" Text="Nil" meta:resourcekey="lblDMNilResource1"></asp:Label>
                                    <asp:Label ID="lblDurationDMAI_5" runat="server" Text="Duration :-" Visible="False"
                                        meta:resourcekey="lblDurationDMAI_5Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trDiabetes1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="tr2" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trStroke" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblStroke__438" runat="server" Text="Stroke " Font-Bold="True" meta:resourcekey="lblStroke__438Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblS_438" runat="server" Text="Nil" meta:resourcekey="lblS_438Resource1"></asp:Label>
                                    <asp:Label ID="lblDateSAI_8" runat="server" Text="Date :-" Visible="False" meta:resourcekey="lblDateSAI_8Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trStroke1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trDyslipidemia" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblDyslipidemia_409" runat="server" Text="Dyslipidemia  " Font-Bold="True"
                            meta:resourcekey="lblDyslipidemia_409Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_409" runat="server" Text="Nil" meta:resourcekey="lblNil_409Resource1"></asp:Label>
                                    <asp:Label ID="lblDurationDLAI_12" runat="server" Text="Duration :-" Visible="False"
                                        meta:resourcekey="lblDurationDLAI_12Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trDyslipidemia1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trCancer" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblCancer_372" runat="server" Text="Cancer " Font-Bold="True" meta:resourcekey="lblCancer_372Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblnil_372" runat="server" Text="Nil" meta:resourcekey="lblnil_372Resource1"></asp:Label>
                                    <asp:Label ID="lblSOCCAI_13" runat="server" Text="Type Of Cancer  :-" Visible="False"
                                        meta:resourcekey="lblSOCCAI_13Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trCancer1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trAsthma" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblAsthma_246" runat="server" Text="Asthma/COPD " Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_246" runat="server" Text="Nil" meta:resourcekey="lblNil_246Resource1"></asp:Label>
                                    <asp:Label ID="lblDurationAAI_16" runat="server" Text="Duration  :-" Visible="False"
                                        meta:resourcekey="lblDurationAAI_16Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trAsthma1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trThalassemia" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblThalassemiaTrait_536" runat="server" Text="Thalassemia Trait  "
                            Font-Bold="True" meta:resourcekey="lblThalassemiaTrait_536Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_536" runat="server" Text="Nil" meta:resourcekey="lblNil_536Resource1"></asp:Label>
                                    <asp:Label ID="lblTraitTTAI_19" runat="server" Text="Trait  :-" Visible="False" meta:resourcekey="lblTraitTTAI_19Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                
                <tr id="trOther" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblOtherDiseases" Visible="false" runat="server" Text="Other Diseases"
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblOtherDiseases_945" runat="server" Text=""></asp:Label>
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
                
                <tr id="trThalassemia1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trHepatitisB" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblHepatitisBcarrier_537" runat="server" Text="Hepatitis B Carrier  "
                            Font-Bold="True" meta:resourcekey="lblHepatitisBcarrier_537Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_537" runat="server" Text="Nil" meta:resourcekey="lblNil_537Resource1"></asp:Label>
                                    <asp:Label ID="lblDurationHBCAI_20" runat="server" Text="Duration  :-" Visible="False"
                                        meta:resourcekey="lblDurationHBCAI_20Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trHepatitisB1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trThyroid" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblThyroid" runat="server" Text="Thyroid  " Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_207" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblDurationThyroid_207" runat="server" Text="Duration  :-" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trThyroid1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trTuberculosis" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblTuberculosis_946" runat="server" Text="Tuberculosis  " Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_946" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblDurationTuberculosis_946" runat="server" Text="Duration  :-" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trTuberculosis1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trPVD" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblPVD_184" runat="server" Text="PVD  " Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_184" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblDurationPVD_184" runat="server" Text="Duration  :-" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPVD1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trRenal" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblRenal_32" runat="server" Text="Renal Disorder  " Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_32" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblDurationRenal_32" runat="server" Text="Duration  :-" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trRenal1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trLiver" style="display: none;" runat="server">
                    <td>
                        <asp:Label ID="lblLiver_78" runat="server" Text="Liver Disease  " Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNil_78" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblDurationLiver_78" runat="server" Text="Duration  :-" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trLiver1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblFamily" runat="server" Text="Family History   " Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                <td></td>
                    <td align="left">
                        <asp:HiddenField ID="hdnFamilyHistory" runat="server" />
                        <div id="divTable" runat="server" style="display: block; border: 1; overflow: auto"
                            align="left">
                        </div>
                    </td>
                </tr>
                <tr id="tr1" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" id="trSurgery" runat="server" style="display: none;"
                cellspacing="0" border="0">
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblSurgery" runat="server" Text="Surgical History   " Font-Bold="True"
                            meta:resourcekey="lblSurgeryResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSurgeryNil" runat="server" Text="Nil" meta:resourcekey="lblSurgeryNilResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                <td></td>
                    <td align="left">
                        <table width="90%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hdnSurgeryHis" runat="server" />
                                    <div id="divSurTable" runat="server" style="display: block; border: 1; overflow: auto"
                                        align="left">
                                    </div>
                                    <asp:GridView ID="grdSurgery" Visible="false" Width="100%" runat="server" CellPadding="4"
                                        AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="grdSurgeryResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:BoundField DataField="SurgeryName" HeaderText="Surgery Name" HeaderStyle-HorizontalAlign="left"
                                                ItemStyle-Width="20%" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="TreatmentPlanDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date"
                                                HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="HospitalName" HeaderText="Hospital/Centre" HeaderStyle-HorizontalAlign="left"
                                                ItemStyle-Width="20%" ItemStyle-HorizontalAlign="Left" />
                                            <%--<asp:TemplateField HeaderText="Surgery Name" ItemStyle-Width="25%" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSurgeryName" runat="server" Text='<%# Bind("SurgeryName") %>' meta:resourcekey="lblSurgeryNameResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="25%"></ItemStyle>
                                    </asp:TemplateField>--%>
                                            <%-- <asp:TemplateField HeaderText="Date" ItemStyle-Width="15%" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTreatmentPlanDate" runat="server" Text='<%# Bind("TreatmentPlanDate") %>'
                                                meta:resourcekey="lblTreatmentPlanDateResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="15%"></ItemStyle>
                                    </asp:TemplateField>--%>
                                            <%--<asp:TemplateField HeaderText="Hospital/Centre" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="lblHospitalName" runat="server" Text='<%# Bind("HospitalName") %>'
                                                meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="5%"></ItemStyle>
                                    </asp:TemplateField>--%>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="divMedicalHistory" runat="server">
    <p class='pagestart'>
    </p>
</div>
<br />--%>
<table id="tblSocialHistory" runat="server" style="display: none;" width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="Label4" runat="server" Text="SOCIAL HISTORY" meta:resourcekey="Label4Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblSocialHistory1" runat="server" style="display: none;" width="100%"
    cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trTobacco" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px" valign="top">
                        <asp:Label ID="lblTobaccoSmoking_476" Font-Bold="True" runat="server" Text="Tobacco Smoking  "
                            meta:resourcekey="lblTobaccoSmoking_476Resource1"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTSNil" runat="server" Text="Nil" meta:resourcekey="lblTSNilResource1"></asp:Label>
                                    <asp:Label ID="lblTypeTS_1" runat="server" Visible="False" Text="Type :- " meta:resourcekey="lblTypeTS_1Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trTSQt" style="display: none;" runat="server">
                                <td nowrap="nowrap" style="width: 200px" valign="top">
                                    <asp:Label ID="Label7" Font-Bold="True" runat="server" Text="Current Status : "></asp:Label>
                                    <asp:Label ID="lblQuitSmk_45" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trTobacco1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trAlcohol" style="display: none;" valign="top" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblAlcoholConsumption_369" Font-Bold="True" runat="server" Text="Alcohol Consumption "
                            meta:resourcekey="lblAlcoholConsumption_369Resource1"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblACNil" runat="server" Text="Nil" meta:resourcekey="lblACNilResource1"></asp:Label>
                                    <asp:Label ID="lblTypeAC_4" runat="server" Visible="False" Text="Type :- " meta:resourcekey="lblTypeAC_4Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trACQt" style="display: none;" runat="server">
                                <td nowrap="nowrap" style="width: 200px" valign="top">
                                    <asp:Label ID="Label8" Font-Bold="True" runat="server" Text="Current Status : "></asp:Label>
                                    <asp:Label ID="lblQuitAC_46" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trAlcohol1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trPhysicial" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblPhysActivity_1059" runat="server" Font-Bold="True" Text="Physicial Activity "
                            meta:resourcekey="lblPhysActivity_1059Resource1"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPhyActNil" runat="server" Text="Nil" meta:resourcekey="lblPhyActNilResource1"></asp:Label>
                                    <asp:Label ID="lblPhyExHead" runat="server" Text="Physicial Exercise :- " Visible="False"
                                        meta:resourcekey="lblPhyExHeadResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPhysicial1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trDietHabit" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px" valign="top">
                        <asp:Label ID="lblDiet" Font-Bold="True" runat="server" Text="Diet Habit"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblDietHabit" runat="server" Text="Nil"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trDietHabit1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trBladder" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblBladder" Font-Bold="True" runat="server" Text="Bladder Habit"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblBladderNil" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblBladderDis" runat="server" Text="Nil"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trBladder1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trBowel" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblBowel" Font-Bold="True" runat="server" Text="Bowel Habit"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblBowelNil" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblBowelDis" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trBowel1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trDrug" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblDrugSub" Font-Bold="True" runat="server" Text="Drug/Substance Abuse"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblDrugSubNil" runat="server" Text="Nil"></asp:Label>
                                    <asp:Label ID="lblDrugSubDis" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trDrug1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<table id="tabAllergy" style="display: none;" runat="server" width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="Label5" runat="server" Text="ALLERGIC HISTORY" meta:resourcekey="Label5Resource1"></asp:Label>
        </td>
    </tr>
</table>--%>
<table width="100%" id="tabAllergy1" style="display: none;" runat="server"  cellpadding="0"
    cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <th align='Left'>ALLERGIC HISTORY</th>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID ="lblAllergyTable" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID ="lblDrugAllergy" Visible ="false" runat="server" />
                    </td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblDrugHistory_1063" runat="server" Font-Bold="True" Visible="false" Text="Drug History "
                            meta:resourcekey="lblDrugHistory_1063Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDHNil" runat="server" Text="Nil" Visible="false" meta:resourcekey="lblDHNilResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdPrescription" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                        ForeColor="#333333" CssClass="mytable1" meta:resourcekey="grdPrescriptionResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Drug Name" ItemStyle-Width="25%" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDrugName" runat="server" Text='<%# Bind("DrugName") %>' meta:resourcekey="lblDrugNameResource1"></asp:Label>
                                                    -
                                                    <asp:Label ID="l1" runat="server" Text="(" meta:resourcekey="l1Resource2"></asp:Label>
                                                    <asp:Label ID="lblDrugFormulation" runat="server" Text='<%# Bind("DrugFormulation") %>'
                                                        meta:resourcekey="lblDrugFormulationResource1"></asp:Label>
                                                    <asp:Label ID="Label1" runat="server" Text=")" meta:resourcekey="Label1Resource2"></asp:Label>
                                                    -<asp:Label ID="Label3" runat="server" Text="(" meta:resourcekey="Label3Resource1"></asp:Label>
                                                    <asp:Label ID="lblDose" runat="server" Text='<%# Bind("Dose") %>' meta:resourcekey="lblDoseResource1"></asp:Label>
                                                    <asp:Label ID="Label2" runat="server" Text=")" meta:resourcekey="Label2Resource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Drug Frequency" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDrugFrequency" runat="server" Text='<%# Bind("DrugFrequency") %>'
                                                        meta:resourcekey="lblDrugFrequencyResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Duration" ItemStyle-Width="15%" meta:resourcekey="TemplateFieldResource6">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDuration" runat="server" Text='<%# Bind("days") %>' meta:resourcekey="lblDurationResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%"></ItemStyle>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="LblVaccinationHistory_1064" Font-Bold="True" runat="server" Visible="false" Text="Vaccination History "
                            meta:resourcekey="LblVaccinationHistory_1064Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="LblVHNil" runat="server" Text="Nil" Visible="false" meta:resourcekey="LblVHNilResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdPPVH" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                        ForeColor="#333333" CssClass="mytable1" meta:resourcekey="grdPPVHResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Vaccination Name" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource7">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVaccinationName" runat="server" Text='<%# Bind("VaccinationName") %>'
                                                        meta:resourcekey="lblVaccinationNameResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vaccination Dose" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource8">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVaccinationDose" runat="server" Text='<%# Bind("VaccinationDose") %>'
                                                        meta:resourcekey="lblVaccinationDoseResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vaccination Time" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource9">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMonthOfVaccination" runat="server" Text='<%# Bind("MonthOfVaccination") %>'
                                                        meta:resourcekey="lblMonthOfVaccinationResource1"></asp:Label>
                                                    <asp:Label ID="txtbar" runat="server" Text="/" meta:resourcekey="txtbarResource1"></asp:Label>
                                                    <asp:Label ID="lblYearOfVaccination" runat="server" Text='<%# Bind("YearOfVaccination") %>'
                                                        meta:resourcekey="lblYearOfVaccinationResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%"></ItemStyle>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="divSocialAllergic" runat="server">
    <p class='pagestart'>
    </p>
</div>
<br />--%>
<table width="100%" runat="server" id="tblGynacHisH" style="display: none">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:HiddenField runat="server" ID="hdnSex" />
            <asp:Label ID="Label6" runat="server" Text="OBSTRETIC/GYNAECOLOGICAL HISTORY" meta:resourcekey="Label6Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="display: none"
    class="dataheaderInvCtrl" runat="server" id="tblGynacHisC">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <table id="tblGynaecological" style="display: none;" runat="server">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td nowrap="nowrap" style="width: 200px">
                                                <asp:Label ID="LblGynaecologicalHitory_1065" Font-Bold="True" runat="server" Text="Gynaecological History "
                                                    meta:resourcekey="LblGynaecologicalHitory_1065Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="LblGHNil" runat="server" Text="Nil" meta:resourcekey="LblGHNilResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%; display: none;" id="tblGynaecological1" runat="server">
                            <tr id="trLMPDate" style="display: none" runat="server">
                                <td style="width: 125px;">
                                    <asp:Label ID="lblLMPDate_13" Font-Bold="True" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        Text="LMP Date" meta:resourcekey="lblLMPDate_13Resource1"></asp:Label>
                                </td>
                                <td style="width: 75px;">
                                    <asp:Label ID="lblLMPDate_38" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblLMPDate_38Resource1"></asp:Label>
                                </td>
                                <td style="width: 160px;">
                                    <asp:Label ID="lblMenstrualCycle_14" Font-Bold="True" Visible="False" runat="server"
                                        CssClass="defaultfontcolor" Text="Menstrual Cycle" meta:resourcekey="lblMenstrualCycle_14Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblMenstrualCyc" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblMenstrualCycResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trCycleLength" style="display: none" runat="server">
                                <td>
                                    <asp:Label ID="lblCycleLength_15" Font-Bold="True" Visible="False" runat="server"
                                        CssClass="defaultfontcolor" Text="Cycle Length(approx)" meta:resourcekey="lblCycleLength_15Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblCycleLength_45" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblCycleLength_45Resource1"></asp:Label>
                                    <asp:Label ID="lblCyclelengthDays" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        Text="days" meta:resourcekey="lblCyclelengthDaysResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLastPapSmear" Font-Bold="True" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        Text="Last Pap Smear" meta:resourcekey="lblLastPapSmearResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLastPapSmear_46" Visible="False" CssClass="defaultfontcolor" runat="server"
                                        meta:resourcekey="lblLastPapSmear_46Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trAgeofMenarchy" style="display: none" runat="server">
                                <td>
                                    <asp:Label ID="lblAgeofMenarchy_18" Font-Bold="True" Visible="False" runat="server"
                                        CssClass="defaultfontcolor" Text="Age of Menarchey" meta:resourcekey="lblAgeofMenarchy_18Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAgeofMenarchy_47" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblAgeofMenarchy_47Resource1"></asp:Label>
                                    <asp:Label ID="lblAgeofMenarchyYears_47" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        Text="Years" meta:resourcekey="lblAgeofMenarchyYears_47Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLastPapSmearResult_19" Font-Bold="True" Visible="False" runat="server"
                                        CssClass="defaultfontcolor" Text="Result" meta:resourcekey="lblLastPapSmearResult_19Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLastPapSmearResult" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblLastPapSmearResultResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trLastMamogram" runat="server" style="display: none">
                                <td>
                                    <asp:Label ID="lblLastMamogram_20" Font-Bold="True" Visible="False" runat="server"
                                        CssClass="defaultfontcolor" Text="Last Mammogram" meta:resourcekey="lblLastMamogram_20Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLastMamogram" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblLastMamogramResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblContraception_17" Font-Bold="True" Visible="False" runat="server"
                                        CssClass="defaultfontcolor" Text="Contraception" meta:resourcekey="lblContraception_17Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblContraception" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblContraceptionResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trLastMamogramResult" runat="server" style="display: none">
                                <td>
                                    <asp:Label ID="lblLastMamogramResult_21" Font-Bold="True" Visible="False" runat="server"
                                        CssClass="defaultfontcolor" Text="Result" meta:resourcekey="lblLastMamogramResult_21Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLastMamogramResult" Visible="False" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblLastMamogramResultResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trHormone" style="display: none" runat="server">
                    <td>
                        <table id="tblHormone" style="display: none;" runat="server">
                            <tr>
                                <td nowrap="nowrap" style="width: 200px">
                                    <asp:Label ID="LblHormoneReplacementTheraphy_1066" Font-Bold="True" runat="server"
                                        Text="Hormone Replacement Therapy" meta:resourcekey="LblHormoneReplacementTheraphy_1066Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="LblHRTil0" runat="server" Text="Nil" meta:resourcekey="LblHRTil0Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trTypeofHRT" style="display: none" runat="server">
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblTypeofHRT_22" runat="server" Visible="False"
                            Text="Type of HRT   :- " meta:resourcekey="lblTypeofHRT_22Resource1"></asp:Label>
                        <asp:Label ID="lblTypeofHRT" runat="server" Visible="False" meta:resourcekey="lblTypeofHRTResource1"></asp:Label>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblHRTDelivery_23" Visible="False" runat="server"
                            Text="HRT Delivery :- " meta:resourcekey="lblHRTDelivery_23Resource1"></asp:Label>
                        <asp:Label ID="lblHRTDelivery" runat="server" meta:resourcekey="lblHRTDeliveryResource1"></asp:Label>
                    </td>
                </tr>
                <tr id="trGravida" style="display: none" runat="server">
                    <td>
                        <asp:Label ID="lblGravida" Font-Bold="True" Visible="False" Text="Gravida : " runat="server"
                            meta:resourcekey="lblGravidaResource1"></asp:Label>
                        <asp:Label ID="lblG" Visible="False" runat="server" meta:resourcekey="lblGResource1"></asp:Label>
                        <asp:Label ID="lblPara" Font-Bold="True" Text="Para : " Visible="False" runat="server"
                            meta:resourcekey="lblParaResource1"></asp:Label>
                        <asp:Label ID="lblP" Visible="False" runat="server" meta:resourcekey="lblPResource1"></asp:Label>
                        <asp:Label ID="lblLive" Font-Bold="True" Text="Live : " Visible="False" runat="server"
                            meta:resourcekey="lblLiveResource1"></asp:Label>
                        <asp:Label ID="lblL" Visible="False" runat="server" meta:resourcekey="lblLResource1"></asp:Label>
                        <asp:Label ID="lblAbortus" Font-Bold="True" Text="Abortus : " Visible="False" runat="server"
                            meta:resourcekey="lblAbortusResource1"></asp:Label>
                        <asp:Label ID="lblA" Visible="False" runat="server" meta:resourcekey="lblAResource1"></asp:Label>
                        <asp:Label ID="lblGPLAOthers" Font-Bold="True" Text="Others : " Visible="False" runat="server"
                            meta:resourcekey="lblGPLAOthersResource1"></asp:Label>
                        <asp:Label ID="lblGPLAO" Visible="False" runat="server" meta:resourcekey="lblGPLAOResource1"></asp:Label>
                    </td>
                </tr>
                <tr id="trObstretic" style="display: none" runat="server">
                    <td>
                        <table id="tblObstretic" style="display: none;" runat="server">
                            <tr>
                                <td nowrap="nowrap" style="width: 200px">
                                    <asp:Label ID="lblOBSTRETICHISTORY_1067" runat="server" Font-Bold="True" Text="Obstretic History  "
                                        meta:resourcekey="lblOBSTRETICHISTORY_1067Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblObsHisNil" runat="server" Text="Nil" meta:resourcekey="lblObsHisNilResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trObstretic1" style="display: none" runat="server">
                    <td>
                        <asp:GridView ID="grdObsHistory" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                            ForeColor="#333333" CssClass="mytable1" meta:resourcekey="grdObsHistoryResource1">
                            <HeaderStyle CssClass="dataheader1" />
                            <Columns>
                                <asp:TemplateField HeaderText="Age / Sex" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource10">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>' meta:resourcekey="lblAgeResource1"></asp:Label>
                                        <asp:Label ID="lblBar1" runat="server" Text="/" meta:resourcekey="lblBar1Resource1"></asp:Label>
                                        <asp:Label ID="lblSexOfChild" runat="server" Text='<%# Bind("SexOfChild") %>' meta:resourcekey="lblSexOfChildResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BirthWeight" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource11">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBirthWeight" runat="server" Text='<%# Bind("BirthWeight") %>' meta:resourcekey="lblBirthWeightResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="GrowthNormal" Visible="false" ItemStyle-Width="5%"
                                    meta:resourcekey="TemplateFieldResource12">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGrowthNormal" runat="server" Text='<%# Bind("GrowthNormal") %>'
                                            meta:resourcekey="lblGrowthNormalResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ModeOfDelivery" ItemStyle-Width="20%" meta:resourcekey="TemplateFieldResource13">
                                    <ItemTemplate>
                                        <asp:Label ID="lblModeOfDelivery" runat="server" Text='<%# Bind("ModeOfDelivery") %>'
                                            meta:resourcekey="lblModeOfDeliveryResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BirthMaturity" ItemStyle-Width="20%" meta:resourcekey="TemplateFieldResource14">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBirthMaturity" runat="server" Text='<%# Bind("BirthMaturity") %>'
                                            meta:resourcekey="lblBirthMaturityResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="divGynacHistory" runat="server">
    <p class='pagestart'>
    </p>
</div>
<br />--%>
<table id="tblPersonalHistory" runat="server" style="display: none;" width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblPersonalHistory" runat="server" Text="PERSONAL HISTORY"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblPersonalHistory1" runat="server" style="display: none;" width="100%"
    cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trEducation" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblEducation" Font-Bold="True" runat="server" Text="Education  " Visible="false"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblEducation1" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trEducation1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trOccupation" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblOccupation" Font-Bold="True" runat="server" Text="Occupation  " Visible="false"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOccupation1" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trOccupation1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                 <tr id="trIncome" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblIncome" Font-Bold="True" runat="server" Text="Income  " Visible="false"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblIncome1" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trIncome1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                 <tr id="trMarital" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblMarital" Font-Bold="True" runat="server" Text="Marital  " Visible="false"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMarital1" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trMarital1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                 <tr id="trOthers" style="display: none;" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblOthers" Font-Bold="True" runat="server" Text="Others Detail  " Visible="false"></asp:Label>
                    </td>
                    <td>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOthers1" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trOthers1" style="display: none;" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
