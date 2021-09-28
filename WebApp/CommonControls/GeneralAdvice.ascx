<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GeneralAdvice.ascx.cs"
    Inherits="CommonControls_GeneralAdvice" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<asp:Panel ID="pnlAdvice" runat="server" meta:resourcekey="pnlAdviceResource1">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="colorforcontent" width="25%" height="23" align="left">
                <div style="display: none" id="ACX2plusAdv">
                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',1);">
                        &nbsp;<asp:Label ID="Rs_GeneralAdvice1" runat="server" Text="General Advice" meta:resourcekey="Rs_GeneralAdvice1Resource1"></asp:Label></span>
                </div>
                <div style="display: block" id="ACX2minusAdv">
                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdv','ACX2minusAdv','ACX2responsesAdv',0);">
                        &nbsp;<asp:Label ID="Rs_GeneralAdvice2" runat="server" Text="General Advice" meta:resourcekey="Rs_GeneralAdvice2Resource1"></asp:Label></span>
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
                                &nbsp;&nbsp;&nbsp;<asp:TextBox runat="server" ID="tTreatmentAdvice" Style="width: 300px;" meta:resourcekey="tTreatmentAdviceResource1"></asp:TextBox>
                                <input type="button" id="gadvNew" value="<%=Resources.ClientSideDisplayTexts.Commoncontrols_GeneralAdvice_ADD %>" tooltip="Add New Advice" class="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" onclick="gAdvControlValidation();return false;" />
                                <asp:Button ID="Clear" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Style="width: 40px" Visible="False" OnClientClick="AdviceControlclear();"
                                    Text="Clear" ToolTip="Clear Drug" meta:resourcekey="ClearResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8" style="height: 15px" align="center">
                                <asp:Label ID="lblAdviceMessage" Text="Advice already exits" ForeColor="Red" runat="server"
                                    Visible="False" meta:resourcekey="lblAdviceMessageResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <div id="gadvTable" runat="server">
    </div>
    <input type="hidden" id="gadid" runat="server"> </input>
</asp:Panel>

<script type="text/javascript" language="javascript">

    function gAdvControlValidation() {
        var retvalue = GenAdvicevalidation();
        if (retvalue != false) {
            gaCmdAdd_onclick(retvalue);
        }
    }
    function gaCmdAdd_onclick(gagotValue) {

        var gaViewStateValue = document.getElementById('<%= hdfAdvice.ClientID %>').value;
        var gaarrayGotValue = new Array();
        var Advice = "";
        //        if (gaViewStateValue != "") {
        //            gaViewStateValue += gagotValue + '|';
        //        }
        //        else {
        //            gaViewStateValue = gagotValue + '|';
        //        }



        var gaarrayAlreadyPresentDatas = new Array();
        var gaiAlreadyPresent = 0;
        var gaiCount = 0;

        var gatempDatas = document.getElementById('<%= hdnAdviceNameExists.ClientID %>').value;

        gaarrayAlreadyPresentDatas = gatempDatas.split('|');
        if (gaarrayAlreadyPresentDatas.length > 0) {
            for (gaiCount = 0; gaiCount < gaarrayAlreadyPresentDatas.length; gaiCount++) {
                if (gaarrayAlreadyPresentDatas[gaiCount].toLowerCase() == gagotValue.toLowerCase()) {
                    gaiAlreadyPresent++;
                }
            }
        }
        if (gaiAlreadyPresent == 0) {
            gatempDatas += gagotValue + "|";
            document.getElementById('<%= hdnAdviceNameExists.ClientID %>').value = gatempDatas;
            gaViewStateValue += "" + gagotValue + "|";
            document.getElementById('<%= hdfAdvice.ClientID %>').value = gaViewStateValue;
            gaCreateJavaScriptTables(gaViewStateValue);
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\GeneralAdvice.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert("Advice already exists"); }
        }
    }
    function gaCreateJavaScriptTables(gaViewStateValue) {
        document.getElementById('<%= gadvTable.ClientID %>').innerHTML = "";
        var ganewTable, gastartTag, gaendTag;
        document.getElementById('<%= hdfAdvice.ClientID %>').value = gaViewStateValue;
        gastartTag = "<TABLE ID='tabGadv1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY><tr><td > "+"<%=Resources.ClientSideDisplayTexts.Commoncontrols_GeneralAdvice_Select %>"+" </td><td style='width:300px;'>"+"<%=Resources.ClientSideDisplayTexts.Commoncontrols_GeneralAdvice_Description %>"+" </td> </tr>";
        gaendTag = "</TBODY></TABLE>";
        ganewTable = gastartTag;

        var gaarrayMainData = new Array();
        var arraySubData = new Array();
        var arrayChildData = new Array();
        var gaiarrayMainDataCount = 0;
        var iarraySubDataCount = 0;
        var Advice;

        gaarrayMainData = gaViewStateValue.split('|');
        if (gaarrayMainData.length > 0) {
            for (gaiarrayMainDataCount = 0; gaiarrayMainDataCount < gaarrayMainData.length - 1; gaiarrayMainDataCount++) {
                Advice = gaarrayMainData[gaiarrayMainDataCount];
                var gachkBoxName = Advice;
                var gaReturnYesOrNo = gaDeletedValueCheck(gachkBoxName);

                if (gaReturnYesOrNo == "Yes") {
                    ganewTable += "<TR><TD><input name='" + Advice + "' onclick='gachkUnCheck(name);'  type='checkbox' /> </TD><TD style=\"WIDTH: 120px\" >" + Advice + "</TD> </TR>";
                }
                else {
                    ganewTable += "<TR><TD><input name='" + Advice + "' onclick='gachkUnCheck(name);'  type='checkbox' checked='checked' /> </TD><TD style=\"WIDTH: 120px\" >" + Advice + "</TD> </TR>";
                }


            }
        }
        ganewTable += gaendTag;
        document.getElementById('<%= gadvTable.ClientID %>').innerHTML += ganewTable;
    }

    function gachkUnCheck(gaDataValue) {

        var gaarrayAlreadyPresentDatas = new Array();
        var gaiAlreadyPresent = 0;
        var gaiCount = 0;

        var gatempDatas = document.getElementById('<%= hdnAdviceDeleted.ClientID %>').value;
        var gaboolAlreadyPresent = false;

        gaarrayAlreadyPresentDatas = gatempDatas.split('|');
        if (gaarrayAlreadyPresentDatas.length > 0) {
            for (gaiCount = 0; gaiCount < gaarrayAlreadyPresentDatas.length; gaiCount++) {
                if (gaarrayAlreadyPresentDatas[gaiCount].toLowerCase() == gaDataValue.toLowerCase()) {
                    gaarrayAlreadyPresentDatas[gaiCount] = "";
                    gaboolAlreadyPresent = true;
                }

            }
        }
        else {
            gatempDatas = "";
            gatempDatas += gaDataValue + "|";
        }
        for (gaiCount = 0; gaiCount < gaarrayAlreadyPresentDatas.length; gaiCount++) {
            gatempDatas += gaarrayAlreadyPresentDatas[gaiCount] + "|";
        }
        if (gaboolAlreadyPresent == false) {
            gatempDatas += gaDataValue + "|";
        }

        document.getElementById('<%= hdnAdviceDeleted.ClientID %>').value = gatempDatas;
    }

    function gaDeletedValueCheck(gaDataValue) {
        var gaarrayAlreadyPresentDatas = new Array();
        var gaiAlreadyPresent = 0;
        var gaiCount = 0;
        var gatempDatas = document.getElementById('<%= hdnAdviceDeleted.ClientID %>').value;
        var garetValueAlreadyPresent = "No";

        gaarrayAlreadyPresentDatas = gatempDatas.split('|');
        if (gaarrayAlreadyPresentDatas.length > 0) {
            for (gaiCount = 0; gaiCount < gaarrayAlreadyPresentDatas.length; gaiCount++) {
                if (gaarrayAlreadyPresentDatas[gaiCount].toLowerCase() == gaDataValue.toLowerCase()) {
                    garetValueAlreadyPresent = "Yes";
                }
            }
        }
        return garetValueAlreadyPresent;
    }
</script>

<asp:HiddenField ID="hdfAdvice" runat="server" />
<asp:HiddenField ID="hdnAdviceNameExists" runat="server" />
<asp:HiddenField ID="hdnAdviceDeleted" runat="server" />
