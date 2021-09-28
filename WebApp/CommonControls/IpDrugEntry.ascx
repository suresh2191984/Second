<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IpDrugEntry.ascx.cs" Inherits="CommonControls_IpDrugEntry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
<script type ="text/javascript" >

    function NewCal1(imgID) {
        var str = imgID.split('_');
        NewCal(str[0] + '_' + str[1] + '_' + 'txtFDate', 'ddmmyyyy', true, 12);
    }
    function NewCal2(imgID) {
        var str = imgID.split('_');
        NewCal(str[0] + '_' + str[1] + '_' + 'txtToDate', 'ddmmyyyy', true, 12);
    }
</script>
<asp:Panel ID="pres" runat="server" meta:resourcekey="presResource1">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="colorforcontent" width="40%" height="23" align="left">
                <div style="display: none" id="ACX2plus111">
                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',1);">
                        &nbsp;<asp:Label ID="Rs_Prescribe1" runat="server" Text="Prescribe" meta:resourcekey="Rs_Prescribe1Resource1"></asp:Label></span>
                </div>
                <div style="display: block" id="ACX2minus111">
                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',0);">
                        &nbsp;<asp:Label ID="Rs_Prescribe2" runat="server" Text="Prescribe" meta:resourcekey="Rs_Prescribe2Resource1"></asp:Label></span>
                </div>
            </td>
        </tr>
        <tr id="ACX2responses111" style="display: block">
            <td class="dataheaderInvCtrl">
                <div>
                    <table width="97%" border="1px" style="border-collapse: collapse;" cellspacing="0"
                        cellpadding="4px">
                        <tr style="background-color: #e2e2e2;">
                            <td style="width: 110px" nowrap="nowrap">
                                <asp:Label ID="Rs_DrugName1" runat="server" Text="DrugName" meta:resourcekey="Rs_DrugName1Resource1"></asp:Label>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:Label ID="Rs_Formulation" runat="server" Text="Formulation" meta:resourcekey="Rs_FormulationResource1"></asp:Label>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:Label ID="Rs_Dose" runat="server" Text="Dose" meta:resourcekey="Rs_DoseResource1"></asp:Label>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:Label ID="Rs_Route" runat="server" Text="Route" meta:resourcekey="Rs_RouteResource1"></asp:Label>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:Label ID="Rs_Frequency" runat="server" Text="Frequency" meta:resourcekey="Rs_FrequencyResource1"></asp:Label>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:Label ID="Duration" runat="server" Text="Duration" meta:resourcekey="DurationResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 110px" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td style="width: 80px" nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tFrm" Style="width: 80px; display: none;" autocomplete="off"
                                    Text="Tab." meta:resourcekey="tFrmResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="tFrm"
                                    ServiceMethod="loadFormulation" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="1" BehaviorID="AutoCompleteEx2" CompletionInterval="500"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    FirstRowSelected="True" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                    DelimiterCharacters="" Enabled="True">
                                </AutoCom:AutoCompleteExtender>
                            </td>
                            <td style="width: 75px" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <input type="text" value="1-0-0" id="tFRQ" runat="server" style="width: 60px; display: none;"
                                    autocomplete="off" />
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:TextBox ID="txtPresID" Style="display: none;" Text="0" runat="server" Width="20px"
                                    meta:resourcekey="txtPresIDResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tDName" Style="width: 100px;" autocomplete="off"
                                    meta:resourcekey="tDNameResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoDname" runat="server" TargetControlID="tDName"
                                    ServiceMethod="getDrugList" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1" CompletionInterval="10"
                                    FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" DelimiterCharacters=""
                                    Enabled="True">
                                </AutoCom:AutoCompleteExtender>
                            </td>
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="ddFormulation" runat="server" meta:resourcekey="ddFormulationResource1">
                                    <asp:ListItem Text="Tab." Value="Tab." meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Text="Syp." Value="Syp." meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    <asp:ListItem Text="Cap." Value="Cap." meta:resourcekey="ListItemResource3"></asp:ListItem>
                                    <asp:ListItem Text="Inj." Value="Inj." meta:resourcekey="ListItemResource4"></asp:ListItem>
                                    <asp:ListItem Text="Ointment" Value="Ointment" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                    <asp:ListItem Text="Supp." Value="Supp." meta:resourcekey="ListItemResource6"></asp:ListItem>
                                    <asp:ListItem Text="Gel" Value="Gel" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                    <asp:ListItem Text="Inhaler" Value="Inhaler" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                    <asp:ListItem Text="Drops" Value="Drops" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                    <asp:ListItem Text="Powder" Value="Powder" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                    <asp:ListItem Text="-Others-" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tDose" Style="width: 75px" autocomplete="off" meta:resourcekey="tDoseResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tDose"
                                    ServiceMethod="loadDose" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="1" BehaviorID="AutoCompleteEx3" CompletionInterval="500"
                                    CompletionListCssClass="wordWheel listMain .box" FirstRowSelected="True" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" DelimiterCharacters=""
                                    Enabled="True">
                                </AutoCom:AutoCompleteExtender>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tROA" Style="width: 100px" autocomplete="off" meta:resourcekey="tROAResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="tROA"
                                    ServiceMethod="loadROA" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="1" BehaviorID="AutoCompleteEx4" CompletionInterval="500"
                                    DelimiterCharacters=";, :" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                </AutoCom:AutoCompleteExtender>
                            </td>
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="ddFrequency" runat="server" Style="width: 75px" meta:resourcekey="ddFrequencyResource1">
                                    <asp:ListItem Text="1-0-0" Value="1-0-0" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                    <asp:ListItem Text="1-0-1" Value="1-0-1" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                    <asp:ListItem Text="1-1-1" Value="1-1-1" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                    <asp:ListItem Text="0-0-1" Value="0-0-1" Selected="True" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                    <asp:ListItem Text="0-1-0" Value="0-1-0" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                    <asp:ListItem Text="1-1-0" Value="1-1-0" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                    <asp:ListItem Text="0-1-1" Value="0-1-1" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                    <asp:ListItem Text="STAT" Value="STAT" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                    <asp:ListItem Text="-Others-" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox ID="tDura" runat="server" Style="display: none;" autocomplete="off"
                                    meta:resourcekey="tDuraResource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlFrequencyNumber" runat="server" meta:resourcekey="ddlFrequencyNumberResource1">
                                    <asp:ListItem meta:resourcekey="ListItemResource21">1</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource22">2</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource23">3</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource24">4</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource25">5</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource26">6</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource27">7</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource28">8</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource29">9</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource30">10</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource31">11</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource32">-</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;
                                <asp:DropDownList ID="ddlFrequencyType" runat="server" meta:resourcekey="ddlFrequencyTypeResource1">
                                    <asp:ListItem meta:resourcekey="ListItemResource33">Day(s)</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource34">Week(s)</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource35">Month(s)</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource36">Year(s)</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="height: 5px;">
                            <td nowrap="nowrap">
                            </td>
                            <td nowrap="nowrap">
                            </td>
                            <td nowrap="nowrap">
                            </td>
                            <td nowrap="nowrap">
                            </td>
                            <td nowrap="nowrap">
                            </td>
                            <td nowrap="nowrap">
                            </td>
                        </tr>
                        <tr style="background-color: #e2e2e2;">
                            <td nowrap="nowrap" colspan="2">
                                <asp:Label ID="Rs_Instruction" runat="server" Text="Instruction" meta:resourcekey="Rs_InstructionResource1"></asp:Label>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:Label ID="Rs_FromDate" runat="server" Text="FromDate" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ToDate" runat="server" Text="ToDate" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td nowrap="nowrap">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="110px" align="left" nowrap="nowrap" colspan="2">
                                <asp:DropDownList ID="ddlInstruction" runat="server" Width="175px" meta:resourcekey="ddlInstructionResource1">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtDate" MaxLength="25" Width="75px" Enabled="false" ></asp:TextBox>
                                     <asp:Image src="../Images/Calendar_scheduleHS.png" ID="imgTDate" onclick="javascript:NewCal2(this.id);"
                                                                Width="16px" Height="16px" border="0" runat="server"  Visible ="false"/>
                      <%-- <a href="javascript:NewCal('txtDate','ddmmyyyy',true,12)">
                                    <img src="../Images/Calendar_scheduleHS.png" id="imgsFDate" runat="server" width="16"
                                        height="16" border="0" />
                                </a>--%>
                            </td>
                            <td style="width: 100px" nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtToDate" MaxLength="25" Width="75px" Enabled="false"
                                   ></asp:TextBox>
                                    <asp:Image src="../Images/Calendar_scheduleHS.png" ID="imgFDate" onclick="javascript:NewCal1(this.id);"
                                                                Width="16px" Height="16px" border="0" runat="server" Visible ="false" />
                           <%--  <a href="javascript:NewCal('txtToDate','ddmmyyyy',true,12)">
                                    <img src="../Images/Calendar_scheduleHS.png" id="imgsTDate" runat="server" width="16"
                                        height="16" border="0" />
                                </a>--%>
                            </td>
                            <td nowrap="nowrap">
                                <input type="button" id="aNew" value="Add" class="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" onclick="ControlValidation();return false;" />
                            </td>
                            <td nowrap="nowrap">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" align="center" nowrap="nowrap">
                                <asp:Label ID="lblDrugMessage" Text="Drug Name already exits" ForeColor="Red" runat="server"
                                    Visible="False" meta:resourcekey="lblDrugMessageResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <div id="dvTable" runat="server">
    </div>
    <input type="hidden" id="did" runat="server"> </input>
    <asp:ObjectDataSource ID="drgFrqSrc" runat="server" EnableCaching="True" SelectMethod="GetDrugFrequencies"
        TypeName="Attune.Solution.BusinessComponent.Uri_BL"></asp:ObjectDataSource>
    </input>
</asp:Panel>
<style type="text/css">
    .list2
    {
        width: 110px;
        border: 1px solid DarkGray;
        list-style-type: none;
        margin: 0px;
        background-color: #fff;
        text-align: left;
        font-size: small;
        vertical-align: middle;
        color: Gray;
        font-family: Verdana;
        font-size: 11px;
    }
    ul.list2 li
    {
        padding: 0px 0px;
    }
    .listitem2
    {
        color: Gray;
    }
    .hoverlistitem2
    {
        background-color: #fff;
    }
    .listMain
    {
        background-color: #fff;
        width: 113px;
        max-height: 150px;
        min-height: 100px;
        text-align: left;
        list-style: none;
        margin-top: -1px;
        font-family: Verdana;
        font-size: 11px;
        overflow: auto;
        padding-left: 1px;
    }
    .wordWheel .itemsMain
    {
        background: none;
        width: 110px;
        border-collapse: collapse;
        color: #383838;
        white-space: nowrap;
        text-align: left;
    }
    .wordWheel .itemsSelected
    {
        width: 110px;
        color: #ffffff;
        background: #;
    }
    .box
    {
        width: 206px;
        height: 168px;
    }
</style>

<script type="text/javascript" language="javascript">

    function adv_loadSelectedValue(id, lstToLoadfrom, ctlToLoadTo, ctlToFocus) {
        if (id == "Formulation") {
            if (document.getElementById('<%= ddFormulation.ClientID %>').options[document.getElementById('<%= ddFormulation.ClientID %>').selectedIndex].innerHTML == "-Others-") {
                document.getElementById('<%= tFrm.ClientID %>').style.display = "block";
            }
            else {
                document.getElementById('<%= tFrm.ClientID %>').style.display = "none";
            }
        }
        else if (id == "Frequency") {
            if (document.getElementById('<%= ddFrequency.ClientID %>').options[document.getElementById('<%= ddFrequency.ClientID %>').selectedIndex].innerHTML == "-Others-") {
                document.getElementById('<%= tFRQ.ClientID %>').style.display = "block";
            }
            else {
                document.getElementById('<%= tFRQ.ClientID %>').style.display = "none";
            }
        }
        else {
        }
        var ctldd = document.getElementById(lstToLoadfrom);
        var txt = document.getElementById(ctlToLoadTo);
        var ctlfocus = document.getElementById(ctlToFocus);
        txt.value = ctldd.options[ctldd.selectedIndex].value;
        if (txt.value == "")
            txt.focus();
    }

    function ControlValidation() {
        var retval = IpDrugEntryValidation();
        if (retval != false) {
            CmdAdd_onclick(retval);
        }
    }

    function CmdAdd_onclick(gotValue) {

        var ViewStateValue = document.getElementById('<%= hdfDrugs.ClientID %>').value;
        var arrayGotValue = new Array();
        arrayGotValue = gotValue.split('~');
        var DrugName, Formulation, Dose, Route, Freq, Dura, Instr, dDate, dDateto, presID;

        if (arrayGotValue.length > 0) {
            DrugName = arrayGotValue[0];
            Formulation = arrayGotValue[1];
            Dose = arrayGotValue[2];
            Route = arrayGotValue[3];
            Freq = arrayGotValue[4];
            Dura = arrayGotValue[5];
            Instr = arrayGotValue[6];
            dDate = arrayGotValue[7];
            dDateto = arrayGotValue[8];
            presID = arrayGotValue[9];

        }
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;

//Check Duplicate Entry

        var ViewStateValueRepeat = document.getElementById('<%= hdfDrugsOthersUsers.ClientID %>').value;
        var arrayGotValueRepeat = new Array();
        arrayGotValueRepeat = gotValue.split('~');
        var DrugNameRepeat, FormulationRepeat, DoseRepeat, RouteRepeat, FreqRepeat, DuraRepeat, InstrRepeat, dDateRepeat, dDatetoRepeat;
        if (arrayGotValueRepeat.length > 0) {
            DrugNameRepeatRepeat = arrayGotValueRepeat[0];
            FormulationRepeat = arrayGotValueRepeat[1];
            DoseRepeat = arrayGotValueRepeat[2];
            RouteRepeat = arrayGotValueRepeat[3];
            FreqRepeat = arrayGotValueRepeat[4];
            DuraRepeat = arrayGotValueRepeat[5];
            InstrRepeat = arrayGotValueRepeat[6];
            dDateRepeat = arrayGotValueRepeat[7];
            dDatetoRepeat = arrayGotValueRepeat[8];

        }
        var arrayAlreadyPresentDatasRepeat = new Array();
        var iAlreadyPresentRepeat = 0;
        var iCountRepeat = 0;
//
        var tempDatas = document.getElementById('<%= hdnDrugNameExists.ClientID %>').value;
        arrayAlreadyPresentDatasRepeat = tempDatas.split('|');
        if (arrayAlreadyPresentDatasRepeat.length > 0) {
            for (iCountRepeat = 0; iCountRepeat < arrayAlreadyPresentDatasRepeat.length; iCountRepeat++) {
                if (arrayAlreadyPresentDatasRepeat[iCountRepeat].toLowerCase() == (DrugName.toLowerCase() + "-" + Formulation.toLowerCase() + "-" + Dose.toLowerCase() + "-" + Route.toLowerCase() + "-" + dDate.toLowerCase() + "-" + dDateto.toLowerCase())) {
                    iAlreadyPresentRepeat++;
                }
            }
        }
        if (iAlreadyPresentRepeat == 0) {
            tempDatas += DrugName + "-" + Formulation + "-" + Dose + "-" + Route + "-" + dDate + "-" + dDateto + "|";
            document.getElementById('<%= hdnDrugNameExists.ClientID %>').value = tempDatas;
            ViewStateValue += "RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FREQ^" + Freq + "~DUR^" + Dura + "~INST^" + Instr + "~DAT^" + dDate + "~DATto^" + dDateto + "~PresID^" + presID + "|";
            document.getElementById('<%= hdfDrugs.ClientID %>').value = ViewStateValue;
            CreateJavaScriptTables();
            IpDrugEntryControlclear();
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\IpDrugEntry.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } 
            else {

                alert("Drug Name already exists");
            }
        }

    }

    function CreateJavaScriptTables() {
        document.getElementById('<%= dvTable.ClientID %>').innerHTML = "";
        var newTable, startTag, endTag;
        var ViewStateValue = document.getElementById('<%= hdfDrugs.ClientID %>').value;
        startTag = "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;'><TBODY><tr><td> Select </td><td style='width:120px;'> DrugName </td><td style='width:80px;'> Formulation </td> <td style='width:75px;'> Dose </td> <td style='width:120px;'> Route </td><td style='display: none; width:75px;'> Frequency </td><td style='display: none; width:75px;'> Duration </td><td style='display: none; width:75px;'> Instruction </td> <td style='width:170px;'> Date </td><td style='width:170px;'> ToDate</td><td style='display: none; width:20px;'> PresID</td><td></td> </tr>";
        endTag = "</TBODY></TABLE>";
        newTable = startTag;

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
                        if (arrayChildData[0] == "DNAME") {
                            DrugName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DFRM") {
                            Formulation = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DDOSE") {
                            Dose = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "ROA") {
                            Route = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "FREQ") {
                            Freq = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DUR") {
                            Dura = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "INST") {
                            Instr = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DAT") {
                            dDate = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DATto") {
                            dDateto = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "PresID") {
                            presID = arrayChildData[1];
                        }
                    }
                }


                var chkBoxName = "RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FREQ^" + Freq + "~DUR^" + Dura + "~INST^" + Instr + "~DAT^" + dDate + "~DATto^" + dDateto + "~PresID^" + presID + "";
                var ReturnYesOrNo = DeletedValueCheck(chkBoxName);
                if (ReturnYesOrNo == "Yes") {
                    newTable += "<TR><TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FREQ^" + Freq + "~DUR^" + Dura + "~INST^" + Instr + "~DAT^" + dDate + "~DATto^" + dDateto + "~PresID^" + presID + "' onclick='chkUnCheck(name);'  type='checkbox' /> "
                    + "</TD><TD style=\"WIDTH: 120px\" >" + DrugName + "</TD>";
                }
                else {
                    newTable += "<TR><TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FREQ^" + Freq + "~DUR^" + Dura + "~INST^" + Instr + "~DAT^" + dDate + "~DATto^" + dDateto + "~PresID^" + presID + "' onclick='chkUnCheck(name);'  type='checkbox' checked='checked' />"
                    + "</TD><TD style=\"WIDTH: 120px\" >" + DrugName + "</TD>";
                }
                newTable += "<TD style=\"WIDTH: 80px\" >" + Formulation + "</TD>";
                newTable += "<TD style=\"WIDTH: 75px\" >" + Dose + "</TD>";
                newTable += "<TD style=\"WIDTH: 120px\" >" + Route + "</TD>";
                newTable += "<TD style=\"display: none; WIDTH: 75px\" >" + Freq + "</TD>";
                newTable += "<TD style=\"display: none; WIDTH: 75px\" >" + Dura + "</TD>";
                newTable += "<TD style=\"display: none; WIDTH: 75px\" >" + Instr + "</TD>";
                newTable += "<TD style=\"WIDTH: 170px\" >" + dDate + "</TD>";
                newTable += "<TD style=\"WIDTH: 170px\" >" + dDateto + "</TD>";
                newTable += "<TD style=\"display: none; WIDTH: 20px\" >" + presID + "</TD>";
                newTable += "<TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FREQ^" + Freq + "~DUR^" + Dura + "~INST^" + Instr + "~DAT^" + dDate + "~DATto^" + dDateto + "~PresID^" + presID + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
            }
        }

        newTable += endTag;
       
        //Update the Previous Table With New Table.
        document.getElementById('<%= dvTable.ClientID %>').innerHTML += newTable;
    }
    function chkUnCheck(DataValue) {
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%= hdnDrugsDeleted.ClientID %>').value;
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
        document.getElementById('<%= hdnDrugsDeleted.ClientID %>').value = tempDatas;
    }

    function DeletedValueCheck(DataValue) {
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%= hdnDrugsDeleted.ClientID %>').value;
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
        var tempDatas = document.getElementById('<%= hdfDrugs.ClientID %>').value;
        //alert(document.getElementById('<%= hdfDrugs.ClientID %>').value);
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
        var arrayDrugName = new Array();
        var arrayFormulation = new Array();
        var arrayDose = new Array();
        var arrayRoute = new Array();
        var arrayFreq = new Array();
        var arrayDura = new Array();
        var arrayInstr = new Array();
        var arrayDate = new Array();
        var arrayDateto = new Array();
        var arrayPresID = new Array();

        arrayGotValue = sEditedData.split('~');
        //alert(arrayGotValue);
        var DrugName, Formulation, Dose, Route, Freq, Dura, Instr, Date, Dateto, presID;

        if (arrayGotValue.length > 0) {
            DrugName = arrayGotValue[1];
            Formulation = arrayGotValue[2];
            Dose = arrayGotValue[3];
            Route = arrayGotValue[4];
            Freq = arrayGotValue[5];
            Dura = arrayGotValue[6];
            Instr = arrayGotValue[7];
            Date = arrayGotValue[8];
            Dateto = arrayGotValue[9];
            presID = arrayGotValue[10];
            arrayDrugName = DrugName.split('^');
            arrayFormulation = Formulation.split('^');
            arrayDose = Dose.split('^');
            arrayRoute = Route.split('^');
            arrayFreq = Freq.split('^');
            arrayDura = Dura.split('^');
            arrayInstr = Instr.split('^');
            arrayDate = Date.split('^');
            arrayDateto = Dateto.split('^');
            arrayPresID = presID.split('^');
        }
        
        if (arrayDrugName.length > 0) {
            document.getElementById('<%= tDName.ClientID %>').value = arrayDrugName[1];
        }
        if (arrayFormulation.length > 0) {
            document.getElementById('<%= tFrm.ClientID %>').value = arrayFormulation[1];
        }
        if (arrayDose.length > 0) {
            document.getElementById('<%= tDose.ClientID %>').value = arrayDose[1];
        }
        if (arrayRoute.length > 0) {
            document.getElementById('<%= tROA.ClientID %>').value = arrayRoute[1];
        }
        if (arrayFreq.length > 0) {
            document.getElementById('<%= tFRQ.ClientID %>').value = arrayFreq[1];
            document.getElementById('<%= ddFrequency.ClientID %>').value = arrayFreq[1];
        }
        if (arrayDura.length > 0) {
            arrayDurationDaysCount = arrayDura[1].split(' ');
            if (arrayDurationDaysCount.length > 0) {
                document.getElementById('<%= ddlFrequencyNumber.ClientID %>').value = arrayDurationDaysCount[0];
                document.getElementById('<%= ddlFrequencyType.ClientID %>').value = arrayDurationDaysCount[1];
            }
        }
        if (arrayInstr.length > 0) {
            document.getElementById('<%= ddlInstruction.ClientID %>').value = arrayInstr[1];
        }
        if (arrayDate.length > 0) {
            document.getElementById('<%= txtDate.ClientID %>').value = arrayDate[1];
        }
        if (arrayDateto.length > 0) {
            document.getElementById('<%= txtToDate.ClientID %>').value = arrayDateto[1];
        }
        if (arrayPresID.length > 0) {
            document.getElementById('<%= txtPresID.ClientID %>').value = arrayPresID[1];
        }
        document.getElementById('<%= hdfDrugs.ClientID %>').value = tempDatas;
        // Delete datas from Drugname Exists Field
        var tempDatas = document.getElementById('<%= hdnDrugNameExists.ClientID %>').value;
        arrayAlreadyPresentDatas = null;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == (arrayDrugName[1].toLowerCase() + "-" + arrayFormulation[1].toLowerCase() + "-" + arrayDose[1].toLowerCase() + "-" + arrayRoute[1].toLowerCase() + "-" + arrayDate[1].toLowerCase() + "-" + arrayDateto[1].toLowerCase())) {
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
        document.getElementById('<%= hdnDrugNameExists.ClientID %>').value = tempDatas;
        CreateJavaScriptTables();
    }
    
</script>

<asp:HiddenField ID="hdfDrugs" runat="server" />
<asp:HiddenField ID="hdfDrugsOthersUsers" runat="server" />
<asp:HiddenField ID="hdnDrugNameExists" runat="server" />
<asp:HiddenField ID="hdnDrugsDeleted" runat="server" />
<asp:HiddenField ID="hdnRoleName" runat="server" />
