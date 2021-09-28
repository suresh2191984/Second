<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SemenAnalysis.ascx.cs"
    Inherits="Investigation_SemenAnalysis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">
    function SemenAddItemsToTable(id) {
        var splitID = id.split('_');
        var type;
        var morphology;
        var Qualifcation;
        var UOM;
        var AddStatus = 0;
        var rowNumber = 0;

        var HidValue = document.getElementById(splitID[0] + '_hSemenResultvalues').value;
        morphology = document.getElementById(splitID[0] + '_txtaMorpholoy').value;
        Qualifcation = document.getElementById(splitID[0] + '_txtQualifcation').value;
        UOM = document.getElementById(splitID[0] + '_lblQUOM').value;

        if ((morphology != "") || (Qualifcation != "") || (UOM != "")) {
            var row = document.getElementById(splitID[0] + '_tblSemenanalysis').insertRow(1);
            rowNumber = HidValue.split('^').length;
            var rowID = splitID[0] + "_" + rowNumber;
            row.id = rowID;

            row.style.fontWeight = "normal";
            row.style.fontsize = "10px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            document.getElementById(splitID[0] + '_tblSemenanalysis').style.display = "block";
            cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] + "_" + rowNumber + "\');\" src=\"../Images/Delete.jpg\" />";
            //alert("<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] +"_"+  rowNumber+"\');\" src=\"../Images/Delete.jpg\" />");
            cell1.width = "5%";
            cell2.innerHTML = morphology;
            cell2.width = "20%"

            cell3.innerHTML = Qualifcation + '%';
            cell3.width = "20%"
            //            cell4.innerHTML = '%';
            //            cell4.width = "20%";
            document.getElementById(splitID[0] + '_hSemenResultvalues').value += "RID:" + rowNumber + "~Morphology:" + morphology + "~Qualifcation:" + Qualifcation + "%^";

            document.getElementById(splitID[0] + '_txtaMorpholoy').value = "";
            document.getElementById(splitID[0] + '_txtQualifcation').value = "";
            //document.getElementById(splitID[0] + '_lblQUOM').value = "";
        }
        return false;
    }

    function ImgOnclick(ImgID) {
        // alert(ImgID);
        var ImgsplitID = ImgID.split('_');
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hSemenResultvalues').value;
        var list = HidValue.split('^');

        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hSemenResultvalues').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (InvesList[0] != 'RID:' + ImgsplitID[1]) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitID[0] + '_hSemenResultvalues').value = newInvList;
        }
    }

    function SAanlysisvalidateSymbol(evt) {
        var keyCode = 0;
        if (evt) {
            keyCode = evt.keyCode || evt.which;
        }
        else {
            keyCode = window.event.keyCode;
        }
        //alert('keyCode  : '+keyCode);
        if ((keyCode == 126) || (keyCode == 94)) {
            return false;
        }
        else {
            return true;
        }
    }


    function LoadExistingSemenItem(hdnValue, idd) {
        //RID:~Morphology:Morphology~Qualifcation:ification%^
        //                alert(hdnValue);
        //                alert(idd);
        var i, y, z, z1, z2;
        var x = hdnValue;
        var splitStr = x.split("^");
        var len = splitStr.length;

        for (i = 0; i < len; i++) {
            if (splitStr[i] != "") {
                y = splitStr[i].split("~");

                if (y[0] != "") {
                    z = y[0].split(":");
                    z1 = y[1].split(":");
                    z2 = y[2].split(":"); //alert(z[1]);
                    if (z[1] != "") {

                        var row = document.getElementById(idd + '_tblSemenanalysis').insertRow(1);
                        var rowID = idd + "_" + z[1];
                        row.id = rowID;
                        row.style.fontWeight = "normal";
                        row.style.fontsize = "10px";
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        //alert('2');
                        document.getElementById(idd + '_tblSemenanalysis').style.display = "block";
                        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
                        cell1.width = "5%";
                        cell2.innerHTML = z1[1];
                        cell2.width = "20%"
                        cell3.innerHTML = z2[1];
                        cell3.width = "20%"
                        //alert('3');
                    }
                }
            }
        }
    }
</script>

<style type="text/css">
    .style1
    {
        width: 30%;
        height: 23px;
    }
    .style2
    {
        height: 23px;
    }
    .style3
    {
        height: 19px;
    }
    .textbox_pattern
    {
        margin-left: 0px;
    }
    .defaultfontcolor
    {
        height: 960px;
    }
    .style4
    {
        height: 21px;
    }
</style>
<table class="defaultfontcolor w-100p">
    <tr>
        <td class="bold font12 h-20" colspan="3" style="color: #000;">
            <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u>Edit</u></a>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlEnabled" runat="server" meta:resourcekey="pnlEnabledResource1">
                <table>
                    <tr>
                        <td colspan="2" style="color: #000;" class="style4 bold font12">
                            <asp:Label ID="Rs_MacroscopyAnalysis" Text="Macroscopy Analysis" runat="server" meta:resourcekey="Rs_MacroscopyAnalysisResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblsemenpH" Text="Semen pH" CssClass="small" meta:resourcekey="lblsemenpHResource1"></asp:Label>
                        </td>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtSemenph" CssClass="small" meta:resourcekey="txtSemenphResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblSemenreaction" Text="Semen Reaction" meta:resourcekey="lblSemenreactionResource1"></asp:Label>
                        </td>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <asp:DropDownList ForeColor="Black" ID="ddlsReaction" CssClass="ddlsmall" onchange="javascript:return setCompletedStatus(this.id);"
                                runat="server" meta:resourcekey="ddlsReactionResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="font12 bold" style="color: #000;">
                            <asp:Label ID="Rs_MicroscopyAnalysis" Text="Microscopy Analysis" runat="server" meta:resourcekey="Rs_MicroscopyAnalysisResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblSpermCount" Text="Sperm Count" meta:resourcekey="lblSpermCountResource1"></asp:Label>
                        </td>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <table class="w-100p">
                                <tr>
                                    <td style="font-weight: normal; color: #000;">
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                            ID="txtSpermCount" CssClass="small" meta:resourcekey="txtSpermCountResource1"></asp:TextBox>
                                    </td>
                                    <td class="a-left font10 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="spermCountUOM" runat="server" Text="x10 ^ 6 Per ml per ejaculate"
                                            meta:resourcekey="spermCountUOMResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left style1" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblOverallMotility" Text="Sperm Overall Motaility"
                                meta:resourcekey="lblOverallMotilityResource1"></asp:Label>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style2 a-left">
                            <asp:DropDownList ForeColor="Black" ID="ddlsMotality" CssClass="ddlsmall" onchange="javascript:return setCompletedStatus(this.id);"
                                runat="server" meta:resourcekey="ddlsMotalityResource1">
                                 <%--<asp:ListItem Text="Select" Value="Select" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                <asp:ListItem Text="gradeIII" Value="gradeIII-active" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                <asp:ListItem Text="gradeII" Value="gradeII-Sluggish" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                <asp:ListItem Text="grade0" Value="grade0-Immotile" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                <asp:ListItem Text="gradeIV" Value="gradeIV-Hyper Motile" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                <asp:ListItem Text="gradeI" Value="gradeI-Very Sluggish" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblHypermotile" Text="Grade IV (Hypermotile) Sperms"
                                meta:resourcekey="lblHypermotileResource1"></asp:Label>
                        </td>
                        <td class="a-left style3" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txthypermotile" CssClass="small" meta:resourcekey="txthypermotileResource1"></asp:TextBox>
                            <asp:Label ID="lblhypermotileUOM" runat="server" Text="%" meta:resourcekey="lblhypermotileUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblActiveSperms" Text="Grade III (Active) Sperms" meta:resourcekey="lblActiveSpermsResource1"></asp:Label>
                        </td>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtactiveSperms" CssClass="small" meta:resourcekey="txtactiveSpermsResource1"></asp:TextBox>
                            <asp:Label ID="lblactiveSuom" runat="server" Text="%" meta:resourcekey="lblactiveSuomResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblSluggishSperm" Text="Grade II (Sluggish) Sperms"
                                meta:resourcekey="lblSluggishSpermResource1"></asp:Label>
                        </td>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtSluggishSperm" CssClass="small" meta:resourcekey="txtSluggishSpermResource1"></asp:TextBox>
                            <asp:Label ID="lblSluggishSpermUOM" runat="server" Text="%" meta:resourcekey="lblSluggishSpermUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblvSluggis" Text="Grade I (Very sluggish) Sperms"
                                meta:resourcekey="lblvSluggisResource1"></asp:Label>
                        </td>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtvSluggish" CssClass="small" meta:resourcekey="txtvSluggishResource1"></asp:TextBox>
                            <asp:Label ID="lblvsugUOM" runat="server" Text="%" meta:resourcekey="lblvsugUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: normal; color: #000;" class="style3 a-left">
                            <asp:Label runat="server" ID="lblImmotileSperms" Text="Grade 0 (Immotile) Sperms"
                                meta:resourcekey="lblImmotileSpermsResource1"></asp:Label>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style3 a-left">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtImmotileSperm" CssClass="small" meta:resourcekey="txtImmotileSpermResource1"></asp:TextBox>
                            <asp:Label ID="lblImmotileSpermUOM" runat="server" Text="%" meta:resourcekey="lblImmotileSpermUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblSpermMorphology" Text="Sperms with Normal Morphology "
                                meta:resourcekey="lblSpermMorphologyResource1"></asp:Label>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style3 a-left">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtSpermMorphology" CssClass="small" meta:resourcekey="txtSpermMorphologyResource1"></asp:TextBox>
                            <asp:Label ID="lblMorphologyUOM" runat="server" Text="%" meta:resourcekey="lblMorphologyUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="font12" style="font-weight: normal;">
                            <table class="dataheaderInvCtrl w-80p">
                                <tr class="colorforcontent">
                                    <td class="font12 a-left" style="font-weight: normal; color: #FFFFFF;">
                                        <asp:Label ID="lblAbnormalMorphology" runat="server" Text="Sperm Morphology" meta:resourcekey="lblAbnormalMorphologyResource1"></asp:Label>
                                    </td>
                                    <td class="font12 a-left" style="font-weight: normal; color: #FFFFFF;" colspan="2">
                                        <asp:Label ID="lblQualification" runat="server" Text="Quantification" meta:resourcekey="lblQualificationResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtaMorpholoy" CssClass="small"
                                            onkeyup="javascript:return setCompletedStatus(this.id);" onkeypress="return SAanlysisvalidateSymbol(event);"
                                            runat="server" meta:resourcekey="txtaMorpholoyResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtQualifcation" onkeyup="javascript:return setCompletedStatus(this.id);"
                                            onkeypress="return SAanlysisvalidateSymbol(event);" CssClass="small" runat="server"
                                            meta:resourcekey="txtQualifcationResource1"></asp:TextBox>
                                        <asp:Label ID="lblQUOM" runat="server" Text="%" meta:resourcekey="lblQUOMResource1"></asp:Label>
                                    </td>
                                    <td class="a-left">
                                        <asp:Button ID="btnADD" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClientClick="return SemenAddItemsToTable(this.id);"
                                            meta:resourcekey="btnADDResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <table id="tblSemenanalysis" class="dataheaderInvCtrl w-100p" runat="server" style="display: none;">
                                            <tr class="colorforcontent" runat="server">
                                                <td class="bold font11 h-8 w-5p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_Delete" Text="Delete" runat="server"></asp:Label>
                                                </td>
                                                <td class="bold font11 h-8 w-20p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_AbnormalMorphology" Text="Abnormal Morphology" runat="server"></asp:Label>
                                                </td>
                                                <td class="bold font11 h-8 w-20p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_Qualification" Text="Qualification" runat="server"></asp:Label>
                                                </td>
                                                <td class="bold font11 h-8 w-20p" style="color: White;" runat="server">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblSpermVitality" Text="Sperm Vitality" meta:resourcekey="lblSpermVitalityResource1"></asp:Label>
                        </td>
                        <td class="a-left font12" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtsVitality" CssClass="small" meta:resourcekey="txtsVitalityResource1"></asp:TextBox>
                            <asp:Label ID="lblsVitalityUOM" runat="server" Text="%live Sperms" meta:resourcekey="lblsVitalityUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table>
                                <tr>
                                    <td class="a-left font11 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label runat="server" ID="lblsAggulination" Text="Sperm Agglutination" meta:resourcekey="lblsAggulinationResource1"></asp:Label>
                                    </td>
                                    <td class="a-left bold" style="color: #000;">
                                        <asp:DropDownList ForeColor="Black" ID="ddlsAgglutination" CssClass="ddlsmall" onchange="javascript:return setCompletedStatus(this.id);"
                                            runat="server" meta:resourcekey="ddlsAgglutinationResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="a-left" style="font-weight: normal; color: #000;">
                                        <asp:Label runat="server" ID="lblEx" Text="Extent of agglination" meta:resourcekey="lblExResource1"></asp:Label>
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                            ID="txtExAgglinaton" CssClass="small" meta:resourcekey="txtExAgglinatonResource1"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblsemenLignefaction" Text="Semen Liquefaction time"
                                meta:resourcekey="lblsemenLignefactionResource1"></asp:Label>
                        </td>
                        <td class="a-left font12" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtlignfacton" onkeyup="javascript:return setCompletedStatus(this.id);"
                                runat="server" CssClass="small" meta:resourcekey="txtlignfactonResource1"></asp:TextBox>
                            <asp:Label ID="lblLignefactonUOM" runat="server" Text="Min" meta:resourcekey="lblLignefactonUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblSleukocytes" Text="Semen Leukocytes(WBCs)" meta:resourcekey="lblSleukocytesResource1"></asp:Label>
                        </td>
                        <td class="a-left font12" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtLeucocytes" onkeyup="javascript:return setCompletedStatus(this.id);"
                                runat="server" CssClass="small" meta:resourcekey="txtLeucocytesResource1"></asp:TextBox>
                            <asp:Label ID="lblWBCsUOM" runat="server" Text="/ml" meta:resourcekey="lblWBCsUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000">
                            <asp:Label runat="server" ID="lblRBCs" Text="Semen RBCs" meta:resourcekey="lblRBCsResource1"></asp:Label>
                        </td>
                        <td class="a-left font12" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtRBCs" onkeyup="javascript:return setCompletedStatus(this.id);"
                                runat="server" CssClass="small" meta:resourcekey="txtRBCsResource1"></asp:TextBox>
                            <asp:Label ID="lblRBCsUOM" runat="server" Text="/ml" meta:resourcekey="lblRBCsUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblPuscells" Text="Semen PusCells" meta:resourcekey="lblPuscellsResource1"></asp:Label>
                        </td>
                        <td class="a-left font12" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtPuscells" CssClass="small"
                                onkeyup="javascript:return setCompletedStatus(this.id);" runat="server" meta:resourcekey="txtPuscellsResource1"></asp:TextBox>
                            <asp:Label ID="lblpuscellsUOM" runat="server" Text="/ml" meta:resourcekey="lblpuscellsUOMResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                            ID="txtRefRange" TextMode="MultiLine" CssClass="textbox_pattern small" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
            <input type="hidden" id="hSemenResultvalues" value="" runat="server" />
        </td>
        <td class="v-top">
            <table>
                <tr>
                    <td class="font11 h-10" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                            meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                    </td>
                    <td class="v-top">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                            ID="txtReason" TextMode="MultiLine" CssClass="textbox_pattern small"
                            meta:resourcekey="txtReasonResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                        &nbsp;&nbsp;<br />
                        <br />
                    </td>
                    <td class="font11 h-10" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                            meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                    <td class="v-top">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            onkeyup="javascript:return setCompletedStatus(this.id);" TabIndex="-1" TextMode="MultiLine"
                            CssClass="textbox_pattern small" meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                        &nbsp;&nbsp;<br />
                        <br />
                    </td>
                    <td class="v-top">
                        <table>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="font10 h-10" style="font-weight: normal; color: #000;">
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
                                    <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                                        onChange="javascript:ShowStatusReason(this.id);" meta:resourcekey="ddlstatusResource1">
                                        <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" CssClass="ddlsmall" 
                                                    runat="server" TabIndex="-1"
                                                    onmousedown="expandDropDownList(this);" 
                                                    onblur="collapseDropDownList(this);" 
                                                    meta:resourcekey="ddlStatusReasonResource1">
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
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
