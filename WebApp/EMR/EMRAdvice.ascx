<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EMRAdvice.ascx.cs" Inherits="EMR_EMRAdvice" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>


<asp:Panel ID="pres" runat="server" meta:resourcekey="presResource1" >
    <table width="97%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="colorforcontent" width="40%" height="23" align="left">
                <div style="display: none" id="ACX2plus111">
                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                        onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',1);">
                       <asp:Label ID="Rs_DrugHistory" Text="DrugHistory" runat="server" 
                        meta:resourcekey="Rs_DrugHistoryResource1"></asp:Label> </span>
                </div>
                <div style="display: block" id="ACX2minus111">
                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                        onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',0);">
                        <asp:Label ID="Rs_DrugHistory1" Text="DrugHistory" runat="server" 
                        meta:resourcekey="Rs_DrugHistory1Resource1"></asp:Label> </span>                        
                </div>
            </td>
            <td width="75%" height="23" align="left">
                &nbsp;
            </td>
        </tr>
        <tr id="ACX2responses111" style="display: block">
            <td colspan="2"  class="dataheaderInvCtrl">
                <div >
                    <table width="97%" border="1px" style="border-collapse:collapse;" cellspacing="0" cellpadding="4px" >
                        <tr style="background-color:#e2e2e2;">
                            <td style="width: 110px" nowrap="nowrap">
                                <asp:Label ID="Rs_DrugName" Text="Drug Name" runat="server" 
                                    meta:resourcekey="Rs_DrugNameResource1"></asp:Label>
                            </td>
                            <td style="width: 80px" nowrap="nowrap">
                                <asp:Label ID="Rs_Formulation" Text="Formulation" runat="server" 
                                    meta:resourcekey="Rs_FormulationResource1"></asp:Label>
                            </td>
                            <td style="width: 80px" nowrap="nowrap">
                                <asp:Label ID="Rs_Dose" Text="Dose" runat="server" 
                                    meta:resourcekey="Rs_DoseResource1"></asp:Label>
                            </td>
                            <td style="display:none;" id="routeBlock1" runat="server" nowrap="nowrap">
                                <asp:Label ID="Rs_Route" Text="Route" runat="server" 
                                    meta:resourcekey="Rs_RouteResource1"></asp:Label>
                            </td>
                            <td style="width: 60px" nowrap="nowrap">
                                Frequency
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Duration" Text="Duration" runat="server" 
                                    meta:resourcekey="Rs_DurationResource1"></asp:Label>
                            </td>
                           
                        </tr>
                        <tr>
                            <td style="width: 110px" nowrap="nowrap">&nbsp;</td>
                            <td style="width: 80px;display:none" nowrap="nowrap" >
                               <asp:TextBox runat="server" ID="tFrm" Style="width: 80px; display: none;" 
                                    autocomplete="off" Text="Tab." meta:resourcekey="tFrmResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="tFrm"
                                    ServiceMethod="loadFormulation" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="1" BehaviorID="AutoCompleteEx2" CompletionInterval="500"
                                    CompletionListCssClass="wordWheel listMain .box" 
                                    CompletionListItemCssClass="wordWheel itemsMain" FirstRowSelected="True"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" 
                                    DelimiterCharacters="" Enabled="True">
                                </AutoCom:AutoCompleteExtender> 
                            </td>
                            <td style="width: 80px" nowrap="nowrap">&nbsp;</td>
                            <td style="width: 80px;display:none;" id="routeBlock2" runat="server" nowrap="nowrap">&nbsp;</td>
                            <td style="width: 60px" nowrap="nowrap">
                                <input type="text" value="0-0-1" id="tFRQ" runat="server" 
                                    style="width: 60px; display: none;" autocomplete="off" />    
                            </td>
                            <td nowrap="nowrap">&nbsp;</td>
                            <td nowrap="nowrap" colspan="2">
                             <asp:TextBox runat="server" ID="txtINS" Style="width: 150px; display: none;" 
                                    autocomplete="off" meta:resourcekey="txtINSResource1" ></asp:TextBox>
                             </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tDName" Style="width: 100px;" 
                                    autocomplete="off" meta:resourcekey="tDNameResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoDname" runat="server" TargetControlID="tDName"
                                    ServiceMethod="getDrugList" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1" 
                                    CompletionInterval="10" FirstRowSelected="True"
                                    CompletionListCssClass="wordWheel listMain .box" 
                                    CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" 
                                    DelimiterCharacters="" Enabled="True">
                                </AutoCom:AutoCompleteExtender>
                            </td>
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="ddFormulation" runat="server" 
                                    meta:resourcekey="ddFormulationResource1">
                                    <asp:ListItem Text="Tab." Value="Tab." meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Text="Syp." Value="Syp." meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    <asp:ListItem Text="Cap." Value="Cap." meta:resourcekey="ListItemResource3"></asp:ListItem>
                                    <asp:ListItem Text="Inj." Value="Inj." meta:resourcekey="ListItemResource4"></asp:ListItem>
                                    <asp:ListItem Text="Ointment" Value="Ointment" 
                                        meta:resourcekey="ListItemResource5"></asp:ListItem>
                                    <asp:ListItem Text="Supp." Value="Supp." meta:resourcekey="ListItemResource6"></asp:ListItem>
                                    <asp:ListItem Text="Gel" Value="Gel" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                    <asp:ListItem Text="Inhaler" Value="Inhaler" 
                                        meta:resourcekey="ListItemResource8"></asp:ListItem>
                                    <asp:ListItem Text="Drops" Value="Drops" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                    <asp:ListItem Text="Powder" Value="Powder" 
                                        meta:resourcekey="ListItemResource10"></asp:ListItem>
                                    <asp:ListItem Text="-Others-" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tDose" Style="width: 100px" autocomplete="off" 
                                    meta:resourcekey="tDoseResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tDose"
                                    ServiceMethod="loadDose" ServicePath="~/WebService.asmx" EnableCaching="False" 
                                    MinimumPrefixLength="1" BehaviorID="AutoCompleteEx3" CompletionInterval="500" 
                                    CompletionListCssClass="wordWheel listMain .box"  FirstRowSelected="True"
                                    CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" 
                                    DelimiterCharacters="" Enabled="True">
                                </AutoCom:AutoCompleteExtender>
                            </td>
                            <td style="display:none;" id="routeBlock3" runat="server" nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tROA" Style="width: 100px" autocomplete="off" 
                                    meta:resourcekey="tROAResource1"></asp:TextBox>
                                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="tROA"
                                    ServiceMethod="loadROA" ServicePath="~/WebService.asmx" 
                                    EnableCaching="False" MinimumPrefixLength="1"
                                    BehaviorID="AutoCompleteEx4" CompletionInterval="500" DelimiterCharacters=";, :"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" 
                                    Enabled="True">
                                </AutoCom:AutoCompleteExtender>
                            </td>
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="ddFrequency" runat="server" style="width: 75px" 
                                    meta:resourcekey="ddFrequencyResource1">
                                    <asp:ListItem Text="1-0-0" Value="1-0-0" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                    <asp:ListItem Text="1-0-1" Value="1-0-1" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                    <asp:ListItem Text="1-1-1" Value="1-1-1" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                    <asp:ListItem Text="0-0-1" Value="0-0-1" Selected="True" 
                                        meta:resourcekey="ListItemResource15"></asp:ListItem>
                                    <asp:ListItem Text="0-1-0" Value="0-1-0" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                    <asp:ListItem Text="1-1-0" Value="1-1-0" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                    <asp:ListItem Text="0-1-1" Value="0-1-1" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                      <asp:ListItem Text="STAT" Value="STAT" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                    <asp:ListItem Text="-Others-" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox ID="tDura" runat="server" Style="display:none;"  
                                    autocomplete="off" meta:resourcekey="tDuraResource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlFrequencyNumber" runat="server" 
                                    meta:resourcekey="ddlFrequencyNumberResource1">
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
                                    <asp:ListItem meta:resourcekey="ListItemResource32">0</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;
                                <asp:DropDownList ID="ddlFrequencyType" runat="server" 
                                    meta:resourcekey="ddlFrequencyTypeResource1">
                                    <asp:ListItem meta:resourcekey="ListItemResource33">Day(s)</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource34">Week(s)</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource35">Month(s)</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource36">Year(s)</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                           
                            <td >
                                <input type="button" id="aNew" value="Add" ToolTip="Add New Drug" class="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" onClick="ControlValidation();return false;"
                                   />
                                </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <div id="dvTable" runat="server">
   
    </div>
    <input type="hidden" id="did" runat="server" >
        </input>
        <asp:ObjectDataSource ID="drgFrqSrc" runat="server" EnableCaching="True" 
            SelectMethod="GetDrugFrequencies" 
            TypeName="Attune.Solution.BusinessComponent.Uri_BL"></asp:ObjectDataSource>
    </input>
</asp:Panel>

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

        //        else
        //            ctlfocus.focus();
    }

    function ControlValidation() {
        var retval = EMRvalidation();
        if (retval != false) {
            CmdAdd_onclick(retval);
        }
    }

    function CmdAdd_onclick(gotValue) {
        var ViewStateValue = document.getElementById('<%= hdfDrugs.ClientID %>').value;


        var arrayGotValue = new Array();
        arrayGotValue = gotValue.split('~');
        var DrugName, Formulation, Dose, Route, Frequency, Duration;

        if (arrayGotValue.length > 0) {
            DrugName = arrayGotValue[0];
            Formulation = arrayGotValue[1];
            Dose = arrayGotValue[2];
            Route = arrayGotValue[3];
            Frequency = arrayGotValue[4];
            Duration = arrayGotValue[5];
            
        }
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;

        var tempDatas = document.getElementById('<%= hdnDrugNameExists.ClientID %>').value;

        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == (DrugName.toLowerCase() + "-" + Formulation.toLowerCase())) {
                    iAlreadyPresent++;
                }
            }
        }
        if (iAlreadyPresent == 0) {
            tempDatas += DrugName + "-" + Formulation + "|";
            document.getElementById('<%= hdnDrugNameExists.ClientID %>').value = tempDatas;
            ViewStateValue += "RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency + "~DURA^" + Duration + "|";
            // newTable += CreateJavaScriptTables(DrugName, Formulation, Dose, Route, Frequency, Duration);
            document.getElementById('<%= hdfDrugs.ClientID %>').value = ViewStateValue;
            document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tROA').value = "";
            CreateJavaScriptTables();
            EMRAdviceControlclear();
        }
        else {
            alert("Drug Name Already Exists!");
        }

    }

    function CreateJavaScriptTables() {

        if (document.getElementById('<%= hdfDrugs.ClientID %>').value != '') {

            document.getElementById('<%= dvTable.ClientID %>').innerHTML = "";
            var newTable, startTag, endTag;
            var ViewStateValue = document.getElementById('<%= hdfDrugs.ClientID %>').value;


            if (document.getElementById('<%= routeBlock1.ClientID %>').style.display == "block") {
                startTag = "<br/><TABLE ID='tabDrg1' Cellpadding='4' Cellspacing='0' Border='1px' style='BackgroundColor:#ff6600;border-collapse:collapse;' ><tr style='height:20px;'><td > Select </td><td style='width:120px;'  > Drug Name </td><td style='width:80px;' > Formulation </td> <td style='width:120px;'  > Dose </td><td style='width:80px;'  > Route </td> <td style='width:80px;'  > Frequency </td><td > Duration </td><td></td> </tr>";
                endTag = "</TABLE>";
            }
            else {
                startTag = "<br/><TABLE ID='tabDrg1' Cellpadding='4' Cellspacing='0' Border='1px' style='BackgroundColor:#ff6600;border-collapse:collapse;' ><tr style='height:20px;'><td > Select </td><td style='width:120px;'  > Drug Name </td><td style='width:80px;' > Formulation </td> <td style='width:120px;'  > Dose </td> <td style='width:80px;'  > Frequency </td><td > Duration </td><td></td> </tr>";
                endTag = "</TABLE>";
            }



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
                            if (arrayChildData[0] == "FRQ") {
                                Frequency = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "DURA") {
                                Duration = arrayChildData[1];
                            }
                          
                        }
                    }
                    var chkBoxName = "RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency + "~DURA^" + Duration +  "";
                    var ReturnYesOrNo = DeletedValueCheck(chkBoxName);
                    if (ReturnYesOrNo == "Yes") {
                        newTable += "<TR><TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency + "~DURA^" + Duration + "~INS^" +"' onclick='chkUnCheck(name);'  type='checkbox' /> "
                    + "</TD><TD style=\"WIDTH: 120px\" >" + DrugName + "</TD>";
                    }
                    else {
                        newTable += "<TR><TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency + "~DURA^" + Duration + "~INS^" + "' onclick='chkUnCheck(name);'  type='checkbox' checked='checked' />"
                    + "</TD><TD style=\"WIDTH: 120px\" >" + DrugName + "</TD>";
                    }
                    newTable += "<TD style=\"WIDTH: 80px\" >" + Formulation + "</TD>";
                    newTable += "<TD style=\"WIDTH: 120px\" >" + Dose + "</TD>";


                    if (document.getElementById('<%= routeBlock1.ClientID %>').style.display == "block") {
                        newTable += "<TD style=\"WIDTH: 120px\" >" + Route + "</TD>";
                    }


                    newTable += "<TD style=\"WIDTH: 80px\" nowrap='nowrap'>" + Frequency + "</TD>";
                    newTable += "<TD >" + Duration + "</TD>";
                   
                    newTable += "<TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DFRM^" + Formulation + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency + "~DURA^" + Duration + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
                }
            }

            newTable += endTag;
            //Update the Previous Table With New Table.
            document.getElementById('<%= dvTable.ClientID %>').innerHTML += newTable;


        }

    }
    function chkUnCheck(DataValue) {
        //        document.getElementById('<%= hdnDrugsDeleted.ClientID %>').value = DataValue;

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
        var arrayFrequency = new Array();
        var arrayDuration = new Array();
        var arrayDurationDaysCount = new Array();
    
        arrayGotValue = sEditedData.split('~');
        var DrugName, Formulation, Dose, Route, Frequency, Duration;

        if (arrayGotValue.length > 0) {
            //            DrugName = arrayGotValue[1];
            //            Formulation = arrayGotValue[2];
            //            Dose = arrayGotValue[3];
            //            Route = arrayGotValue[4];
            //            Frequency = arrayGotValue[5];
            //            Duration = arrayGotValue[6];

            DrugName = arrayGotValue[1];
            Formulation = arrayGotValue[2];
            Dose = arrayGotValue[3];
            Route = arrayGotValue[4];
            Frequency = arrayGotValue[5];
            Duration = arrayGotValue[6];
           

            arrayDrugName = DrugName.split('^');
            arrayFormulation = Formulation.split('^');
            arrayDose = Dose.split('^');
            arrayRoute = Route.split('^');
            arrayFrequency = Frequency.split('^');
            arrayDuration = Duration.split('^');
          
         

           

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

        if (arrayFrequency.length > 0) {
            document.getElementById('<%= tFRQ.ClientID %>').value = arrayFrequency[1];
            document.getElementById('<%= ddFrequency.ClientID %>').value = arrayFrequency[1];
        }
      
        
        if (arrayDuration.length > 0) {
            arrayDurationDaysCount = arrayDuration[1].split(' ');
            if (arrayDurationDaysCount.length > 0) {
                document.getElementById('<%= ddlFrequencyNumber.ClientID %>').value = arrayDurationDaysCount[0];
                document.getElementById('<%= ddlFrequencyType.ClientID %>').value = arrayDurationDaysCount[1];
            }
        }
        document.getElementById('<%= hdfDrugs.ClientID %>').value = tempDatas;
        // Delete datas from Drugname Exists Field
        var tempDatas = document.getElementById('<%= hdnDrugNameExists.ClientID %>').value;
        arrayAlreadyPresentDatas = null;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {

                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == (arrayDrugName[1].toLowerCase() + "-" + arrayFormulation[1].toLowerCase())) {
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
<asp:HiddenField ID="hdnDrugNameExists" runat="server" />
<asp:HiddenField ID="hdnDrugsDeleted" runat="server" />

<script language="javascript" type="text/javascript">
    CreateJavaScriptTables();
</script>