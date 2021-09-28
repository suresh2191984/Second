<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NutritionAdvice.ascx.cs" Inherits="CommonControls_NutritionAdvice" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>

<asp:Panel ID="pnlAdvice" runat="server" meta:resourcekey="pnlAdviceResource1">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="colorforcontent" width="25%" height="23" align="left">
                <div style="display: none" id="ACX2plusAdv">
                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',1);">
                        &nbsp;<asp:Label ID="Rs_GeneralAdvice1" runat="server" Text="Nutrition Advice"></asp:Label></span>
                </div>
                <div style="display: block" id="ACX2minusAdv">
                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',0);">
                        &nbsp;<asp:Label ID="Rs_GeneralAdvice2" runat="server" Text="Nutrition Advice"></asp:Label></span>
                </div>
            </td>
            <td width="75%" height="23" align="left">
                &nbsp;
            </td>
        </tr>
        <tr id="ACX2responsesAdv" style="display: block">
            <td colspan="2">
                <div class="dataheader2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                        <tr>
                            <td colspan="8" style="height: 15px">
                            </td>
                        </tr>
                        <tr>
                            <td width="10px">
                                &nbsp;
                            </td>
                            <td colspan="6" style="width: 80%">
                            </td>
                            <td width="10px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>                            
                            <td colspan="7">
                                &nbsp;&nbsp;&nbsp;<asp:TextBox runat="server" ID="tNTreatmentAdvice" Style="width: 300px;"></asp:TextBox>
                                <input type="button" id="gadvNew" value="Add" tooltip="Add New Advice" class="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" onclick="gNAdvControlValidation();return false;" />
                                <asp:Button ID="Clear" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Style="width: 40px" Visible="False" OnClientClick="return NAdviceControlclear();"
                                    Text="Clear" ToolTip="Clear Drug" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8" style="height: 15px" align="center">
                                <asp:Label ID="lblAdviceMessage" Text="Advice already exits" ForeColor="Red" runat="server"
                                    Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <div id="gNadvTable" runat="server">
    </div>
    <input type="hidden" id="gadid" runat="server"> </input>
</asp:Panel>

<script type="text/javascript" language="javascript">

    function gNAdvControlValidation() {
        var retvalue = NAdvicevalidation();
        if (retvalue != false) {
            gaNCmdAdd_onclick(retvalue);
        }
    }
    function gaNCmdAdd_onclick(NgagotValue) {

        var gaNViewStateValue = document.getElementById('<%= hdnNuAdvice.ClientID %>').value;
        var gNaarrayGotValue = new Array();
        var Advice = "";
        //        if (gaNViewStateValue != "") {
        //            gaNViewStateValue += gagotValue + '|';
        //        }
        //        else {
        //            gaNViewStateValue = gagotValue + '|';
        //        }



        var gNaarrayAlreadyPresentDatas = new Array();
        var gNaiAlreadyPresent = 0;
        var gNaiCount = 0;

        var gaNtempDatas = document.getElementById('<%= hdnNAdviceNameExists.ClientID %>').value;

        gNaarrayAlreadyPresentDatas = gaNtempDatas.split('|');
        if (gNaarrayAlreadyPresentDatas.length > 0) {
            for (NgaiCount = 0; NgaiCount < gNaarrayAlreadyPresentDatas.length; NgaiCount++) {
                if (gNaarrayAlreadyPresentDatas[NgaiCount].toLowerCase() == NgagotValue.toLowerCase()) {
                    gNaiAlreadyPresent++;
                }
            }
        }
        if (gNaiAlreadyPresent == 0) {
            gaNtempDatas += NgagotValue + "|";
            document.getElementById('<%= hdnNAdviceNameExists.ClientID %>').value = gaNtempDatas;
            gaNViewStateValue += "" + NgagotValue + "|";
            document.getElementById('<%= hdnNuAdvice.ClientID %>').value = gaNViewStateValue;
            gaNAdvCreateJavaScriptTables(gaNViewStateValue);
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionAdvice.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {

                alert("Advice already exists");
            }
        }
    }
    function gaNAdvCreateJavaScriptTables(gaNViewStateValue) {
        document.getElementById('<%= gNadvTable.ClientID %>').innerHTML = "";
        var NganewTable, NgastartTag, NgaendTag;
        document.getElementById('<%= hdnNuAdvice.ClientID %>').value = gaNViewStateValue;
        NgastartTag = "<TABLE ID='tabNadv1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY><tr><td > Select </td><td style='width:300px;'> Description </td> </tr>";
        NgaendTag = "</TBODY></TABLE>";
        NganewTable = NgastartTag;

        var NgaarrayMainData = new Array();
        var NarraySubData = new Array();
        var NarrayChildData = new Array();
        var NgaiarrayMainDataCount = 0;
        var NiarraySubDataCount = 0;
        var NAdvice;

        NgaarrayMainData = gaNViewStateValue.split('|');
        if (NgaarrayMainData.length > 0) {
            for (NgaiarrayMainDataCount = 0; NgaiarrayMainDataCount < NgaarrayMainData.length - 1; NgaiarrayMainDataCount++) {
                NAdvice = NgaarrayMainData[NgaiarrayMainDataCount];
                var NgachkBoxName = NAdvice;
                var NgaReturnYesOrNo = NgaDeletedValueCheck(NgachkBoxName);

                if (NgaReturnYesOrNo == "Yes") {
                    NganewTable += "<TR><TD><input name='" + NAdvice + "' onclick='NgachkUnCheck(name);'  type='checkbox' /> </TD><TD style=\"WIDTH: 120px\" >" + NAdvice + "</TD> </TR>";
                }
                else {
                    NganewTable += "<TR><TD><input name='" + NAdvice + "' onclick='NgachkUnCheck(name);'  type='checkbox' checked='checked' /> </TD><TD style=\"WIDTH: 120px\" >" + NAdvice + "</TD> </TR>";
                }


            }
        }
        NganewTable += NgaendTag;
        document.getElementById('<%= gNadvTable.ClientID %>').innerHTML += NganewTable;
    }

    function NgachkUnCheck(NgaDataValue) {

        var NgaarrayAlreadyPresentDatas = new Array();
        var NgaiAlreadyPresent = 0;
        var NgaiCount = 0;

        var NgatempDatas = document.getElementById('<%= hdnNAdviceDeleted.ClientID %>').value;
        var NgaboolAlreadyPresent = false;

        NgaarrayAlreadyPresentDatas = NgatempDatas.split('|');
        if (NgaarrayAlreadyPresentDatas.length > 0) {
            for (NgaiCount = 0; NgaiCount < NgaarrayAlreadyPresentDatas.length; NgaiCount++) {
                if (NgaarrayAlreadyPresentDatas[NgaiCount].toLowerCase() == NgaDataValue.toLowerCase()) {
                    NgaarrayAlreadyPresentDatas[NgaiCount] = "";
                    NgaboolAlreadyPresent = true;
                }

            }
        }
        else {
            NgatempDatas = "";
            NgatempDatas += NgaDataValue + "|";
        }
        for (NgaiCount = 0; NgaiCount < NgaarrayAlreadyPresentDatas.length; NgaiCount++) {
            NgatempDatas += NgaarrayAlreadyPresentDatas[NgaiCount] + "|";
        }
        if (NgaboolAlreadyPresent == false) {
            NgatempDatas += NgaDataValue + "|";
        }

        document.getElementById('<%= hdnNAdviceDeleted.ClientID %>').value = NgatempDatas;
    }

    function NgaDeletedValueCheck(NgaDataValue) {
        var NgaarrayAlreadyPresentDatas = new Array();
        var NgaiAlreadyPresent = 0;
        var NgaiCount = 0;
        var NgatempDatas = document.getElementById('<%= hdnNAdviceDeleted.ClientID %>').value;
        var NgaretValueAlreadyPresent = "No";

        NgaarrayAlreadyPresentDatas = NgatempDatas.split('|');
        if (NgaarrayAlreadyPresentDatas.length > 0) {
            for (NgaiCount = 0; NgaiCount < NgaarrayAlreadyPresentDatas.length; NgaiCount++) {
                if (NgaarrayAlreadyPresentDatas[NgaiCount].toLowerCase() == NgaDataValue.toLowerCase()) {
                    NgaretValueAlreadyPresent = "Yes";
                }
            }
        }
        return NgaretValueAlreadyPresent;
    }
</script>

<asp:HiddenField ID="hdnNuAdvice" runat="server" />
<asp:HiddenField ID="hdnNAdviceNameExists" runat="server" />
<asp:HiddenField ID="hdnNAdviceDeleted" runat="server" />

