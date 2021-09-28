<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SampleCollection.ascx.cs" Inherits="CommonControls_SampleCollection" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
    <script src="../Scripts/bid.js" type="text/javascript"></script>
     <script src="../Scripts/Common.js" type="text/javascript"></script>
<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>
<script language="javascript" type="text/javascript">
    function mapSample(id) {
        //alert(document.getElementById('ucSC_hdnSampleInvMapping').value);
       // alert(id);
        var x, y, z, a;

        if (document.getElementById(id).checked) {
            x = document.getElementById('ucSC_hdnSampleInvMapping').value.split("^");
            y = x.length;
            for (i = 0; i < y; i++) {
                if (x[i] != "") {
                    z = x[i].split("~");
                    if (z[0] != "") {
                        a = id.split("_");
                        if (z[0] == a[1]) {
                            document.getElementById('ucSC_hdnSampleInvMappingTemp').value += z[0] + "~" + z[1] + "~" + z[2] + "~" + z[3] + "^";
                           // alert(document.getElementById('ucSC_hdnSampleInvMappingTemp').value);
                        }
                    }
                }
            }
        }
        else {
           
            x = document.getElementById('ucSC_hdnSampleInvMappingTemp').value.split("^");
            y = x.length;
            document.getElementById('ucSC_hdnSampleInvMappingTemp').value = "";
            for (i = 0; i < y; i++) {
                if (x[i] != "") {
                    z = x[i].split("~");
                    if (z[0] != "") {
                        a = id.split("_");
                        if (z[0] != a[1]) {
                            document.getElementById('ucSC_hdnSampleInvMappingTemp').value += z[0] + "~" + z[1] + "~" + z[2] + "~" + z[3] + "^";
                           // alert(document.getElementById('ucSC_hdnSampleInvMappingTemp').value);
                        }
                    }
                }
            }
        }
            }
</script>
        <table border="0"  cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                
                <div id="ACX2minus3" style="display: block;color:#000;height:20px;" runat="server">
             <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
             style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ucSC_sampleInvMappingTab',0);" />
             <span style="cursor: pointer;color:#000;" onclick="showResponses('ACX2plus3','ACX2minus3','ucSC_sampleInvMappingTab',0);">
             &nbsp;View / Select Sample Used For Corresponding Investigation</span>
             </div>
               <div id="ACX2plus3" style="display: none;color:#000;height:20px;" runat="server">
            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
             onclick="showResponses('ACX2plus3','ACX2minus3','ucSC_sampleInvMappingTab',1);" />
             <span style="cursor: pointer;color:#000;" onclick="showResponses('ACX2plus3','ACX2minus3','ucSC_sampleInvMappingTab',1);">
             &nbsp;View / Select Sample Used For Corresponding Investigation</span>
             </div>
             
                <asp:Table ID="sampleInvMappingTab" CssClass="dataheaderInvCtrl" style="display:block;" runat="server" CellPadding="4" CellSpacing="0" BorderWidth="0">
                </asp:Table>
                <input type="hidden" id="hdnSampleInvMapping" runat="server" />
                <input type="hidden" id="hdnSampleInvMappingTemp" runat="server" />
                <input type="hidden" id="hdnSample" value="" runat="server" />
            
            <br />
             <div id="ACX2minus2" style="display: block;color:#000;height:20px;">
             <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
             style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','tabAttributes',0);" />
             <span style="cursor: pointer;color:#000;" onclick="showResponses('ACX2plus2','ACX2minus2','tabAttributes',0);">
             &nbsp;View / Add Sample Attributes</span>
             </div>
             <div id="ACX2plus2" style="display: none;color:#000;height:20px;">
            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
             onclick="showResponses('ACX2plus2','ACX2minus2','tabAttributes',1);" />
             <span style="cursor: pointer;color:#000;" onclick="showResponses('ACX2plus2','ACX2minus2','tabAttributes',1);">
             &nbsp;View / Add Sample Attributes</span>
             </div>
                
                <table border="0" id="tabAttributes" style="display:block;" cellpadding="0" cellspacing="0" width="100%">

                        <tr>
                            <td>
                                <asp:Panel ID="Panel1"  Width="100%" BorderWidth="0px" runat="server">

                                    <table border="0" class="dataheader2" cellpadding="5"  cellspacing="0" width="100%">
                                        <tr style="height:15px; " class="Duecolor">
                                            <td style="width:30%;"><b>Samples</b></td>
                                            <td style="width:14%;"><b>Attributes</b></td>
                                            <td style="width:22%;"><b>Values</b></td>
                                            <td style="width:22%;"><b>Description</b></td>
                                            <td style="width:12%;">&nbsp;</td>
                                        </tr>
                                        <tr>

                                            <td style="width:30%;" >
                                                <asp:DropDownList ID="ddlSamples" Width="200px"  runat="server"></asp:DropDownList>
                                            </td>
                                            <td style="width:14%;" >
                                                <asp:DropDownList ID="ddlAttributes"  runat="server"></asp:DropDownList>
                                            </td>
                                            <td style="width:22%;" >
                                                <asp:TextBox ID="txtValues" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width:22%;" >
                                                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width:12%;" align="center" >
                                                    <input type="button" id="aNew" value="Add" ToolTip="Add New Drug" class="btn"
                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" onClick="SampleValidation();return false;" />
                                            
                                            </td>
                                        </tr>
                                    </table>
                                     <div id="dvTable" runat="server" class="dataheaderInvCtrl" style="width:96%;"></div>   
                                    
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                
                </td>
            </tr>
            <%--<tr>
                <td>

                    <table border="0" cellpadding="0px"  cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <asp:Panel ID="Panel2" CssClass="dataheader2" Width="100%" BorderWidth="0px" runat="server">

                                   <table border="0" cellpadding="5" runat="server" id="tabSampleHeader" style="display:none;"  cellspacing="0" width="50%">
                                        <tr style="height:15px; color: #ffffff; background-color: #;">
                                            <td style="width:5%;"><b>Remove</b></td>
                                            <td style="width:25%;"><b>Samples</b></td>
                                            <td style="width:10%;"><b>Color</b></td>
                                            <td style="width:10%;"><b>Appearance</b></td>
                                            <td style="width:10%;"><b>Description</b></td>
                                           <td style="width:10%;"><b>Odour</b></td>
                                            <td style="width:10%;"><b>Consistency</b></td>
                                            <td style="width:10%;"><b>Viscosity</b></td>                                           
                                        </tr>
                                    </table>
                                     <table id="tblSelectedSamples" style=" border:0;border-color:#; border-style:solid; border-collapse:collapse;" runat="server" cellpadding="0" cellspacing="0" width="100%">
                                     </table>
                                </asp:Panel>
                               
                                   
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>--%>
        </table>
        <input type="hidden" id="did" runat="server" />
        <asp:HiddenField ID="hdnSampleExists" runat="server" />
        <asp:HiddenField ID="hdnSampleDeleted" runat="server" />
                        
<script language="javascript" type="text/javascript">
    function SampleValidation() {
        var retSample = invSampleValidation();
        if (retSample != false) {
            CmdAdd_onclick(retSample);
        }
    }
    function CmdAdd_onclick(gotValue) {
        var ViewStateValue = document.getElementById('<%= hdnSample.ClientID %>').value;

        var arrayGotValue = new Array();
        arrayGotValue = gotValue.split('~');

        var SampleNameCode, SampleName, SampleAttributesCode, SampleAttributes, SampleValue, SampleDescription;

        if (arrayGotValue.length > 0) {
            SampleNameCode = arrayGotValue[0];
            SampleName = arrayGotValue[1];
            SampleAttributesCode = arrayGotValue[2];
            SampleAttributes = arrayGotValue[3];
            SampleValue = arrayGotValue[4];
            SampleDescription = arrayGotValue[5];
        }
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;

        var tempDatas = document.getElementById('<%= hdnSampleExists.ClientID %>').value;

        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == (SampleNameCode.toLowerCase() + "-" + SampleAttributesCode.toLowerCase())) {
                    iAlreadyPresent++;
                }
            }
        }
        if (iAlreadyPresent == 0) {
            tempDatas += SampleNameCode + "-" + SampleAttributesCode + "|";
            document.getElementById('<%= hdnSampleExists.ClientID %>').value = tempDatas;
            ViewStateValue += "RID^" + 0 + "~SNC^" + SampleNameCode + "~SN^" + SampleName + "~SAC^" + SampleAttributesCode + "~SA^" + SampleAttributes + "~SV^" + SampleValue + "~SD^" + SampleDescription + "|";
            // newTable += CreateJavaScriptTables(SampleNameCode, SampleName, SampleAttributesCode, SampleAttributes, SampleValue, SampleDescription);
            document.getElementById('<%= hdnSample.ClientID %>').value = ViewStateValue;
            CreateJavaScriptTables();
            //AdviceControlclear();
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SampleCollection.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Sample already exists");
            }
        }
    }

    function CreateJavaScriptTables() {
       
        document.getElementById('<%= dvTable.ClientID %>').innerHTML = "";
        var newTable, startTag, endTag;
        var ViewStateValue = document.getElementById('<%= hdnSample.ClientID %>').value;
        //alert(document.getElementById('<%= hdnSample.ClientID %>').value);
        startTag = "<TABLE ID='tabDrg1' Cellpadding='4' width='100%' Cellspacing='1' Border='0' style='BackgroundColor:#ff6600;' ><TBODY><tr><td style='color:#000;width:10%;'> <u>Select</u> </td><td style='width:120px;display:none;'  > SampleNameCode </td><td style='width:120px;color:#000;width:20%;'  > <u>Sample</u></td><td style='width:80px;display:none;' > AttributesCode </td><td style='width:80px;color:#000;width:20%;' > <u>Attributes</u> </td> <td style='width:120px;color:#000;width:20%;'><u> Values</u> </td> <td style='width:80px;color:#000;width:20%;'><u> Description </u> </td><td></td> </tr>";
        endTag = "</TBODY></TABLE>";
        newTable = startTag;
        var RWID = 0;
        var arrayMainData = new Array();
        var arraySubData = new Array();
        var arrayChildData = new Array();
        var iarrayMainDataCount = 0;
        var iarraySubDataCount = 0;

        arrayMainData = ViewStateValue.split('|');
        if (arrayMainData.length > 0) {
            for (iarrayMainDataCount = 0; iarrayMainDataCount < arrayMainData.length - 1; iarrayMainDataCount++) {

                arraySubData = arrayMainData[iarrayMainDataCount].split('~');
                for (iarraySubDataCount = 0; iarraySubDataCount < arraySubData.length; iarraySubDataCount++) {
                    arrayChildData = arraySubData[iarraySubDataCount].split('^');
                    if (arrayChildData.length > 0) {

                        if (arrayChildData[0] == "RID") {
                            RWID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "SNC") {
                            SampleNameCode = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "SN") {
                            SampleName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "SAC") {
                            SampleAttributesCode = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "SA") {
                            SampleAttributes = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "SV") {
                            SampleValue = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "SD") {
                            SampleDescription = arrayChildData[1];
                        }
                    }
                }
                var chkBoxName = "RID^" + RWID + "~SNC^" + SampleNameCode + "~SN^" + SampleName + "~SAC^" + SampleAttributesCode + "~SA^" + SampleAttributes + "~SV^" + SampleValue + "~SD^" + SampleDescription + "";
                var ReturnYesOrNo = DeletedValueCheck(chkBoxName);
                if (ReturnYesOrNo == "Yes") {
                    newTable += "<TR style='font-weight:normal;color:#000;'><TD><input name='RID^" + RWID + "~SNC^" + SampleNameCode + "~SN^" + SampleName + "~SAC^" + SampleAttributesCode + "~SA^" + SampleAttributes + "~SV^" + SampleValue + "~SD^" + SampleDescription + "' onclick='chkUnCheck(name);'  type='checkbox' /> "
                    + "</TD><TD style=\"WIDTH: 120px;\" >" + SampleName + "</TD>";
                }
                else {
                    newTable += "<TR style='font-weight:normal;color:#000;'><TD><input name='RID^" + RWID + "~SNC^" + SampleNameCode + "~SN^" + SampleName + "~SAC^" + SampleAttributesCode + "~SA^" + SampleAttributes + "~SV^" + SampleValue + "~SD^" + SampleDescription + "' onclick='chkUnCheck(name);'  type='checkbox' checked='checked' />"
                    + "</TD><TD style=\"WIDTH: 120px;display:none;\" >" + SampleNameCode + "</TD>";
                }
                newTable += "<TD style=\"WIDTH: 80px\" >" + SampleName + "</TD>";
                newTable += "<TD style=\"WIDTH: 80px;display:none;\" >" + SampleAttributesCode + "</TD>";
                newTable += "<TD style=\"WIDTH: 80px\" >" + SampleAttributes + "</TD>";
                newTable += "<TD style=\"WIDTH: 120px\" >" + SampleValue + "</TD>";
                newTable += "<TD style=\"WIDTH: 80px\" >" + SampleDescription + "</TD>";
                newTable += "<TD><input name='RID^" + RWID + "~SNC^" + SampleNameCode + "~SN^" + SampleName + "~SAC^" + SampleAttributesCode + "~SA^" + SampleAttributes + "~SV^" + SampleValue + "~SD^" + SampleDescription + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR style='font-weight:normal;color:#000;'>";
            }
        }

        newTable += endTag;
        //Update the Previous Table With New Table.
        document.getElementById('<%= dvTable.ClientID %>').innerHTML += newTable;
        document.getElementById('<%= dvTable.ClientID %>').style.display = "block";
    }
    function chkUnCheck(DataValue) {
        //        document.getElementById('<%= hdnSampleDeleted.ClientID %>').value = DataValue;

        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;

        var tempDatas = document.getElementById('<%= hdnSampleDeleted.ClientID %>').value;
        var boolAlreadyPresent = false;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == DataValue.toLowerCase()) {
                    arrayAlreadyPresentDatas[iCount] = "";
                    boolAlreadyPresent = true;
                }
            }
        }

        tempDatas = "";
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
            if (arrayAlreadyPresentDatas[iCount] != "") {
                tempDatas += arrayAlreadyPresentDatas[iCount] + "|";
            }
        }
        if (boolAlreadyPresent == false) {
            tempDatas += DataValue + "|";
        }
        document.getElementById('<%= hdnSampleDeleted.ClientID %>').value = tempDatas;

    }

    function DeletedValueCheck(DataValue) {
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%= hdnSampleDeleted.ClientID %>').value;
        var retValueAlreadyPresent = "No";

        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == DataValue.toLowerCase()) {
                    retValueAlreadyPresent = "Yes";
                }
            }
        }
        return retValueAlreadyPresent;
    }

    function btnEdit_OnClick(sEditedData) {

        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        
        var tempDatas = document.getElementById('<%= hdnSample.ClientID %>').value;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase()) {
                    arrayAlreadyPresentDatas[iCount] = "";
                }
            }
        }

        tempDatas = "";
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
            if (arrayAlreadyPresentDatas[iCount] != "") {
                tempDatas += arrayAlreadyPresentDatas[iCount] + "|";
            }
        }

        var arrayGotValue = new Array();
        var arraySampleNameCode = new Array();
        var arraySampleName = new Array();
        var arraySampleAttributesCode = new Array();
        var arraySampleAttributes = new Array();
        var arraySampleValue = new Array();
        var arraySampleDescription = new Array();

        arrayGotValue = sEditedData.split('~');
        var SampleNameCode, SampleName, SampleAttributesCode, SampleAttributes, SampleValue, SampleDescription;

        if (arrayGotValue.length > 0) {
            SampleNameCode = arrayGotValue[1];
            SampleName = arrayGotValue[2];
            SampleAttributesCode = arrayGotValue[3];
            SampleAttributes = arrayGotValue[4];
            SampleValue = arrayGotValue[5];
            SampleDescription = arrayGotValue[6];

            arraySampleNameCode = SampleNameCode.split('^');
            arraySampleName = SampleName.split('^');
            arraySampleAttributesCode = SampleAttributesCode.split('^');
            arraySampleAttributes = SampleAttributes.split('^');
            arraySampleValue = SampleValue.split('^');
            arraySampleDescription = SampleDescription.split('^');
        }

        if (arraySampleNameCode.length > 0) {
            document.getElementById('<%= ddlSamples.ClientID %>').value = arraySampleNameCode[1];
        }
        if (arraySampleAttributesCode.length > 0) {
            document.getElementById('<%= ddlAttributes.ClientID %>').value = arraySampleAttributesCode[1];
        }
        if (arraySampleValue.length > 0) {
            document.getElementById('<%= txtValues.ClientID %>').value = arraySampleValue[1];
        }
        if (arraySampleAttributes.length > 0) {
            document.getElementById('<%= txtDescription.ClientID %>').value = arraySampleDescription[1];
        }

        document.getElementById('<%= hdnSample.ClientID %>').value = tempDatas;
        // Delete datas from Drugname Exists Field
        var tempDatas = document.getElementById('<%= hdnSampleExists.ClientID %>').value;
        arrayAlreadyPresentDatas = null;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == (arraySampleNameCode[1].toLowerCase() + "-" + arraySampleAttributesCode[1].toLowerCase())) {
                    arrayAlreadyPresentDatas[iCount] = "";
                }
            }
        }
        tempDatas = "";
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
            if (arrayAlreadyPresentDatas[iCount] != "") {
                tempDatas += arrayAlreadyPresentDatas[iCount] + "|";
            }
        }
        document.getElementById('<%= hdnSampleExists.ClientID %>').value = tempDatas;
       
        CreateJavaScriptTables();
    }
    if (document.getElementById('<%= hdnSample.ClientID %>').value != "") {
        CreateJavaScriptTables();
        document.getElementById('<%= dvTable.ClientID %>').style.display = "block";
    }
    else {
        document.getElementById('<%= dvTable.ClientID %>').style.display = "none";
    }
    
   </script>
    </ContentTemplate>
</asp:UpdatePanel>

