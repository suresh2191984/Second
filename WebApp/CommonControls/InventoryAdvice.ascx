<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InventoryAdvice.ascx.cs"
    Inherits="CommonControls_InventoryAdvice" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
<link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.watermark.min.js" type="text/javascript"></script>

<div id="divwidth">
</div>
<style type="text/css">
    #div1
    {
        position: relative;
    }
    #div1 select
    {
        position: absolute;
        top: 0px;
        left: 0px;
    }
</style>

<script type="text/javascript" language="javascript">
    $(function() {
        //        alert($("#uIAdv_txtINS").attr('title'));
        var txtUserTitle = $("#uIAdv_txtINS").attr('title');
        $("#uIAdv_txtINS").watermark(txtUserTitle);
    });

    function IAmSelected(source, eventArgs) {

        var list = eventArgs.get_value().split('^');
        if (list.length > 0) {

            if (list[4] == 'Y') {
                if (confirm('Selected product has been marked as Banned. Do you still wish to use this?')) {

                }
                else {
                    document.getElementById('<%= tDName.ClientID %>').value = "";
                    document.getElementById('<%= hdnProductID.ClientID %>').value = "";
                    document.getElementById('<%= tDName.ClientID %>').focus();
                    return false;
                }
            }
            for (i = 0; i < list.length; i++) {
                var Status = "";
                if (list[i] != "") {
                    Status = list[3];
                    if (Status == 'Y') {
                        var i;
                        i = confirm('The Drug is already Prescribed.Do you want to continue?');
                        if (i == true) {

                            return true;
                        }
                        else {
                            return false;
                        }
                    }
                }
            }
        }
    }
    
</script>

<asp:Panel ID="pres" runat="server" meta:resourcekey="presResource1">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="colorforcontent" width="100%" height="23" align="left" colspan="2">
                <div style="display: none" id="ACX2plus111">
                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',1);">
                        &nbsp;<asp:Label ID="Rs_Prescribe" runat="server" Text="Prescribe" meta:resourcekey="Rs_PrescribeResource1"></asp:Label></span>
                </div>
                <div style="display: block" id="ACX2minus111">
                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus111','ACX2minus111','ACX2responses111',0);">
                        &nbsp;<asp:Label ID="Rs_Prescribe1" runat="server" Text="Prescribe" meta:resourcekey="Rs_Prescribe1Resource1"></asp:Label></span>
                </div>
            </td>
        </tr>
        <tr id="ACX2responses111" style="display: block">
            <td colspan="2" class="dataheaderInvCtrl">
                <div>
                    <table width="100%" border="1px" style="border-collapse: collapse;" cellspacing="0"
                        cellpadding="4px">
                        <asp:Label ID="lblPrescribeDrugExpiredDate" Font-Bold="True" runat="server" meta:resourcekey="lblPrescribeDrugExpiredDateResource1"></asp:Label>
                        <tr style="background-color: #e2e2e2;">
                            <td style="width: 150px" nowrap="nowrap">
                                <asp:Label ID="Rs_DrugName" runat="server" Text="Drug Name" meta:resourcekey="Rs_DrugNameResource1"></asp:Label>
                                <asp:CheckBox ID="ChckAllDrug" Text="All Drugs" runat="server" />
                                &nbsp;&nbsp;<asp:Label ID="lbllocations" runat="server" Text="Location" Font-Bold="True"
                                    Visible="False" meta:resourcekey="lbllocationsResource1" />
                                <asp:DropDownList ID="drplocation" runat="server" onchange="return loadlocation();"
                                    Visible="False" meta:resourcekey="drplocationResource1">
                                </asp:DropDownList>
                            </td>
                            <td style="display: none; width: 10px" nowrap="nowrap" id="DoseBlock1" runat="server">
                                <asp:Label ID="Rs_Dose" runat="server" Text="Dose" meta:resourcekey="Rs_DoseResource1"></asp:Label>
                            </td>
                            <td style="display: none;" id="routeBlock1" runat="server" nowrap="nowrap">
                                <asp:Label ID="Rs_Route" runat="server" Text="Route" meta:resourcekey="Rs_RouteResource1"></asp:Label>
                            </td>
                            <td style="width: 60px" nowrap="nowrap">
                                <asp:Label ID="Rs_Frequency" runat="server" Text="Frequency" meta:resourcekey="Rs_FrequencyResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" style="width: 80px;">
                                <asp:Label ID="Rs_Direction" runat="server" Text="Direction" meta:resourcekey="Rs_DirectionResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" style="width: 60px;">
                                <asp:Label ID="Rs_Duration" runat="server" Text=" Duration" meta:resourcekey="Rs_DurationResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" style="width: 49px;">
                                <asp:Label ID="lblOty" runat="server" Text="Qty" meta:resourcekey="lblOtyResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Instruction" runat="server" Text="Instruction" meta:resourcekey="Rs_InstructionResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 110px" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td style="display: none; width: 80px" nowrap="nowrap" id="DoseBlock2" runat="server">
                                &nbsp;
                            </td>
                            <td style="width: 80px; display: none;" id="routeBlock2" runat="server" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td style="width: 160px" nowrap="nowrap">
                                <input type="text" value="0-0-1" id="tFRQ" runat="server" style="width: 60px; display: none;"
                                    autocomplete="off" />
                                <asp:Label ID="tFRQ1" Text="Example(M-A-N)" ForeColor="Red" runat="server" Style="width: 60px;
                                    display: none;" meta:resourcekey="tFRQ1Resource1"></asp:Label>
                            </td>
            </td>
            <td nowrap="nowrap">
                &nbsp;
            </td>
            <td nowrap="nowrap">
            </td>
            <td nowrap="nowrap" style="width: 49px;">
            </td>
            <td nowrap="nowrap">
                <asp:TextBox runat="server" ID="txtINS" Style="width: 150px; display: block;" autocomplete="off"
                    meta:resourcekey="txtINSResource1"></asp:TextBox>
            </td>
            <td nowrap="nowrap">
            </td>
        </tr>
        <tr>
            <td nowrap="nowrap">
                <asp:TextBox runat="server" ID="tDName" Style="width: 200px;" autocomplete="off"
                    OnChange="javascript:GetText(this.value);" meta:resourcekey="tDNameResource1"
                    onkeypress="javascript:Getdatas();"></asp:TextBox>
                <AutoCom:AutoCompleteExtender ID="AutoDname" runat="server" TargetControlID="tDName"
                    ServiceMethod="getInvDrugList" OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx"
                    EnableCaching="False" MinimumPrefixLength="1" BehaviorID="AutoCompleteExInvenAdv1"
                    CompletionInterval="10" FirstRowSelected="True" CompletionListCssClass="wordWheelOne listMainOne .boxOne"
                    CompletionListItemCssClass="wordWheelOne itemsMainOne" CompletionListHighlightedItemCssClass="wordWheelOne itemsSelectedOne"
                    CompletionListElementID="divwidth" DelimiterCharacters="" Enabled="True">
                </AutoCom:AutoCompleteExtender>
                <asp:HiddenField ID="hdnProductID" runat="server" />
                <asp:HiddenField ID="hdnAutoID" Value="0" runat="server" />
                <asp:HiddenField ID="hdnTaskID" Value="0" runat="server" />
            </td>
            <td nowrap="nowrap" style="display: none;" id="DoseBlock3" runat="server">
                <asp:TextBox runat="server" ID="tDose" Style="width: 100px" autocomplete="off" meta:resourcekey="tDoseResource1"></asp:TextBox>
                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tDose"
                    ServiceMethod="loadDose" ServicePath="~/WebService.asmx" EnableCaching="False"
                    MinimumPrefixLength="1" BehaviorID="AutoCompleteExInvenAdv3" CompletionInterval="500"
                    CompletionListCssClass="wordWheel listMain .box" FirstRowSelected="True" CompletionListItemCssClass="wordWheel itemsMain"
                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" DelimiterCharacters=""
                    Enabled="True">
                </AutoCom:AutoCompleteExtender>
            </td>
            <td style="display: none;" id="routeBlock3" runat="server" nowrap="nowrap">
                <asp:TextBox runat="server" ID="tROA" Style="width: 100px" autocomplete="off" meta:resourcekey="tROAResource1"></asp:TextBox>
                <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="tROA"
                    ServiceMethod="loadROA" ServicePath="~/WebService.asmx" EnableCaching="False"
                    MinimumPrefixLength="1" BehaviorID="AutoCompleteExInvenAdv4" CompletionInterval="500"
                    DelimiterCharacters=";, :" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                </AutoCom:AutoCompleteExtender>
            </td>
            <td nowrap="nowrap" valign="top">
                <div id="div1">
                    <asp:DropDownList ID="ddFrequency" runat="server" Width="140px" onmouseover="this.size=10"
                        onmouseout="this.size=1" onclick="this.size=1" onblur="this.size=1" onfocus="this.size=10"
                        meta:resourcekey="ddFrequencyResource1">
                    </asp:DropDownList>
                </div>
            </td>
            <td nowrap="nowrap">
                <asp:DropDownList ID="ddDirection" runat="server" Width="300px" Enabled="False" meta:resourcekey="ddDirectionResource1">
                </asp:DropDownList>
            </td>
            <td nowrap="nowrap">
                <asp:TextBox ID="tDura" runat="server" Style="display: none;" autocomplete="off"
                    meta:resourcekey="tDuraResource1"></asp:TextBox>
                <asp:TextBox ID="txtFrequencyNumber" Text="1" runat="server" Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"  
                    meta:resourcekey="txtFrequencyNumberResource1"></asp:TextBox>
                &nbsp;
                <asp:DropDownList ID="ddlFrequencyType" runat="server" meta:resourcekey="ddlFrequencyTypeResource1">
                </asp:DropDownList>
            </td>
            <td style="width: 49px;">
                <asp:TextBox ID="txtQty" runat="server" Width="56px" meta:resourcekey="txtQtyResource1"></asp:TextBox>
            </td>
            <td width="180px" align="left" nowrap="nowrap">
                <asp:DropDownList ID="ddlInstruction" runat="server" Width="150px" onchange="javascript:showInsTxt(this.value);"
                    meta:resourcekey="ddlInstructionResource1">
                </asp:DropDownList>
            </td>
            <td>
                <input type="button" id="aNew" value="<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_ADD %>" tooltip="Add New Drug" class="btn" onmouseover="this.className='btn btnhov'"
                    onmouseout="this.className='btn'" onclick="ControlValidation();return false;" />
            </td>
        </tr>
    </table>
    </div> </td> </tr> </table>
    <div id="dvTable" runat="server">
    </div>
    <input type="hidden" id="did" runat="server"> </input>
    </input>
    <asp:HiddenField ID="hdnlocationid" runat="server" />
    </input>
    <asp:ObjectDataSource ID="drgFrqSrc" runat="server" EnableCaching="True" SelectMethod="GetDrugFrequencies"
        TypeName="Attune.Solution.BusinessComponent.Uri_BL"></asp:ObjectDataSource>
    </input>
</asp:Panel>

<script language="JavaScript">
    function onlyNumbers(evt) {
        var e = event || evt; // for trans-browser compatibility
        var charCode = e.which || e.keyCode;

        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

        return true;

    }
    function OnChangeddDirection(DDl) {

    }
    function Drugcalculationother() {
        if (document.getElementById('<%= ddFrequency.ClientID %>').value == '-Others-') {
            document.getElementById('<%= hdnDrugcalculation.ClientID %>').value = '0.00';
            var RE_SSN = /^\d*[0-9](|\.\d*[0-9])-\d*[0-9](|\.\d*[0-9])-\d*[0-9](\.\d*[0-9])?$/;
            if (RE_SSN.test(document.getElementById('uIAdv_tFRQ').value)) {
            }
            //            else {
            //                alert("The drug frequency format provided is not valid. Please redefine the format(M-A-N)");
            //                document.getElementById('uIAdv_tFRQ').focus();
            //                return false;
            //            }
            var txtDay = document.getElementById('<%= txtFrequencyNumber.ClientID %>').value;
            var ddlInst = document.getElementById('<%= ddlFrequencyType.ClientID %>').value;
            var FrequencyType;
            var total;
            if (ddlInst == 'Day(s)') {
                FrequencyType = 1;
            }
            else if (ddlInst == 'Week(s)') {
                FrequencyType = 7;
            }
            else if (ddlInst == 'Month(s)') {
                FrequencyType = 30;
            }
            else {
                FrequencyType = 365;
            }
            var temoTotal = 0.00;
            if (document.getElementById('<%= hdnDrugcalculation.ClientID %>').value == '0.00') {
                var ddFreq = document.getElementById('uIAdv_tFRQ').value;
                var arrayFreq = ddFreq.split('-');
                for (var i = 0; i < arrayFreq.length; i++) {
                    temoTotal += Number(arrayFreq[i]);
                }
            }

            total = Number(FrequencyType) * Number(txtDay);
            var ttotal = format_number(Number(temoTotal) * Number(total), 1);
            var T = ttotal.toString();
            var totals = T.split('.');
            if (totals[1] == '0') {
                document.getElementById('<%= txtQty.ClientID %>').value = format_number(T, 2);
            }
            else {
                document.getElementById('<%= txtQty.ClientID %>').value = format_number(T, 2);
            }
            document.getElementById('<%= txtQty.ClientID %>').value = format_number(T, 2);
            document.getElementById('<%= hdnDrugcalculation.ClientID %>').value = format_number(T, 2);
            return true;
        }
    }
    function Drugcalculation() {
        if (document.getElementById('<%= txtFrequencyNumber.ClientID %>').value != '') {
            var txtDay = document.getElementById('<%= txtFrequencyNumber.ClientID %>').value;
            var ddlInst = document.getElementById('<%= ddlFrequencyType.ClientID %>').value;
            var FrequencyType;
            var total;
            if (ddlInst == 'Day(s)') {
                FrequencyType = 1;
            }
            else if (ddlInst == 'Week(s)') {
                FrequencyType = 7;
            }
            else if (ddlInst == 'Month(s)') {
                FrequencyType = 30;
            }
            else {
                FrequencyType = 365;
            }
            var temoTotal = 0.00;
            temoTotal = document.getElementById('<%= hdnDrugcalculation.ClientID %>').value;
            total = Number(FrequencyType) * Number(txtDay);
            var ttotal = format_number(Number(temoTotal) * Number(total), 1);
            var T = ttotal.toString();
            var totals = T.split('.');
            if (totals[1] == '0') {
                document.getElementById('<%= txtQty.ClientID %>').value = format_number(T, 2);
            }
            else {
                //                alert('The drug frequency format provided is not valid. Please redefine.');
                document.getElementById('<%= txtFrequencyNumber.ClientID %>').focus();
                document.getElementById('<%= txtQty.ClientID %>').value = format_number(T, 2);
                return false;
            }
            document.getElementById('<%= txtQty.ClientID %>').value = format_number(T, 2);
            return true;
        }
        else {
            //alert('Please enter the Frequency.');
            document.getElementById('<%= txtQty.ClientID %>').value = document.getElementById('<%= hdnDrugcalculation.ClientID %>').value;
            return false;
        }

    }
</script>

<script type="text/javascript" language="javascript">
   function loadlocation() {
       // var locid = document.getElementById('<%=drplocation.ClientID %>').value;
        // $find('AutoCompleteExInvenAdv1').set_contextKey("<%=Request.QueryString["VID"] %>" + "~" + locid);
        //debugger;
        var vid=0;
        alert(document.getElementById('<%=hdnVid.ClientID %>').value);
        if(document.getElementById('<%=hdnVid.ClientID %>').value!="none")
        {
         vid=document.getElementById('<%=hdnVid.ClientID %>').value;
           
        }
        else{
                vid="<%=Request.QueryString["VID"] %>";
        }
       
       $find('AutoCompleteExInvenAdv1').set_contextKey(vid + "~" + -1);
    }
function Getdatas() {

    var locid=0;
    if(document.getElementById('<%= ChckAllDrug.ClientID %>').checked==true)
    {
        locid=-1;
    }
     var vid=0;
      
        if(document.getElementById('<%=hdnVid.ClientID %>').value!="none")
        {
         vid=document.getElementById('<%=hdnVid.ClientID %>').value;
          
        }
        else{
                
                vid="<%=Request.QueryString["VID"] %>";
        }

        $find('AutoCompleteExInvenAdv1').set_contextKey(vid + "~" + locid); 
}
    function GetText(pBrandName) {
   
    
        if (pBrandName != "") {
            var Temp = pBrandName.split('^');          
            document.getElementById('<%= tDName.ClientID %>').value = Temp[0];
            document.getElementById('<%= hdnProductID.ClientID %>').value = Temp[2];
            if (document.getElementById('<%= tDName.ClientID %>').value == "undefined") {
                document.getElementById('<%= tDName.ClientID %>').value = "";
                document.getElementById('<%= hdnProductID.ClientID %>').value = "";
            }
        }       
    }

    function showInsTxt(InsID) {


//        document.getElementById('<%= txtINS.ClientID %>').value = "";
//        if (InsID == "Other") {
            document.getElementById('<%= txtINS.ClientID %>').style.display = "block";
//        }
//        else {
//            document.getElementById('<%= txtINS.ClientID %>').style.display = "none";
//        }
    }

    function adv_loadSelectedValue(id, lstToLoadfrom, ctlToLoadTo, ctlToFocus) {

         if (id == "Frequency") {
        if (document.getElementById('<%= ddFrequency.ClientID %>').options[document.getElementById('<%= ddFrequency.ClientID %>').selectedIndex].innerHTML == "-Others-") {
                document.getElementById('<%= tFRQ.ClientID %>').style.display = "block";
                document.getElementById('<%= tFRQ1.ClientID %>').style.display = "block";
                document.getElementById('uIAdv_ddDirection').style.display = "none";
            }
            else {
                document.getElementById('<%= tFRQ.ClientID %>').style.display = "none";
                document.getElementById('<%= tFRQ1.ClientID %>').style.display = "none";
                 document.getElementById('uIAdv_ddDirection').style.display = "block";
            }
        }
        else {
        }
        var ctldd = document.getElementById(lstToLoadfrom);
        var txt = document.getElementById(ctlToLoadTo);
        var ctlfocus = document.getElementById(ctlToFocus);
        if(ctldd.options[ctldd.selectedIndex].value=='-Others-')
        {
        txt.value='0-0-1';
        
        }
        else{
        txt.value = ctldd.options[ctldd.selectedIndex].value;
        }
        //txt.value = ctldd.options[ctldd.selectedIndex].value;

        if (txt.value == "")
            txt.focus();
       
//        else
//            ctlfocus.focus();
        var ddFreq = document.getElementById('<%= ddFrequency.ClientID %>').value;
        var Direction = document.getElementById('<%= hdnDirection.ClientID %>').value.split('^');
        for (var i = 0; i < Direction.length - 1; i++) {
            var item = Direction[i].split('~');
            if(ddFreq==item[0])
            {
                document.getElementById('<%= ddDirection.ClientID %>').value=item[1];
                document.getElementById('<%= hdnDrugcalculation.ClientID %>').value=item[2];
                //document.getElementById('<%= txtQty.ClientID %>').value=item[2];
            }
        }
    }

    function ControlValidation() {
        var retval = InventoryValidation();
        if (retval!=false) {
              CmdAdd_onclick(retval);
        }
    }

    function CmdAdd_onclick(gotValue) {
//        //debugger;
        var ViewStateValue = document.getElementById('<%= hdfDrugs.ClientID %>').value;
        
        
        var arrayGotValue = new Array();
        arrayGotValue = gotValue.split('~');
       
        var DrugName,  Dose, Route, Frequency,Direction, Duration, Instruction,ProductID,AutoID,TaskID,Qty;

        if (arrayGotValue.length > 0) {
            DrugName = arrayGotValue[0];
          //  Formulation = arrayGotValue[1];
            Dose = arrayGotValue[1];
            Route = arrayGotValue[2];
            Frequency = arrayGotValue[3];
            Direction = arrayGotValue[4];
            Duration = arrayGotValue[5];
            Instruction = arrayGotValue[6];
            ProductID = arrayGotValue[7];
            AutoID=arrayGotValue[8];
            TaskID=arrayGotValue[9];
            Qty=arrayGotValue[10];
        }
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount =0;

 
        
        var arrayAlreadyPresentDatasRepeat = new Array();
        var iAlreadyPresentRepeat = 0;
        var iCountRepeat = 0;
        //
        var tempDatas1 = document.getElementById('<%= hdfDrugs.ClientID %>').value;
        arrayAlreadyPresentDatasRepeat = tempDatas1.split('~');
        for (var j = 0; j < arrayAlreadyPresentDatasRepeat.length; j++) {
            if (arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'DNAME') {
                var arraydrugs = arrayAlreadyPresentDatasRepeat[j].split('^')[1];
                if (arraydrugs.length > 0) {
//                    for (iCountRepeat = 0; iCountRepeat < arraydrugs.length; iCountRepeat++) {
                       if (arraydrugs.toLowerCase() == (DrugName.toLowerCase())) {
                            iAlreadyPresentRepeat++;
                        }
                   // }
                }
            }
        }
          if (iAlreadyPresentRepeat == 0) {
            tempDatas1 += DrugName;
            document.getElementById('<%= hdfDrugs.ClientID %>').value = tempDatas1;
            ViewStateValue += "RID^" + 0 + "~DNAME^" + DrugName + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency +"~DIR^" + Direction + "~DURA^" + Duration + "~INS^" + Instruction + "~PID^" + ProductID + "~AutoID^" + AutoID+  "~TaskID^" + TaskID +  "~Qty^" + Qty+"|";
            document.getElementById('<%= hdfDrugs.ClientID %>').value = ViewStateValue;
            CreateJavaScriptTables();
            InventoryAdviceControlclear();
           
        }
        else {

            var i;
            i = confirm("Drug Name already exists! Do you want to continue ");
            if (i == true) {
                document.getElementById('<%= hdfDrugs.ClientID %>').value = tempDatas1;
                ViewStateValue += "RID^" + 0 + "~DNAME^" + DrugName + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency +"~DIR^" + Direction + "~DURA^" + Duration + "~INS^" + Instruction + "~PID^" + ProductID + "~AutoID^" + AutoID+  "~TaskID^" + TaskID+ "~Qty^" + Qty+"|";
                document.getElementById('<%= hdfDrugs.ClientID %>').value = ViewStateValue;
                CreateJavaScriptTables();
                InventoryAdviceControlclear();
                return true;
            }
            else {
                InventoryAdviceControlclear();      
                return false;
            }
         
           // alert("Drug Name already exists! Do you want to continue ");
        }
    
      
        
       
    }

    function CreateJavaScriptTables() {
        
        if (document.getElementById('<%= hdfDrugs.ClientID %>').value != '') {
            
            document.getElementById('<%= dvTable.ClientID %>').innerHTML = "";
            var newTable, startTag, endTag;
            var ViewStateValue = document.getElementById('<%= hdfDrugs.ClientID %>').value;
            // document.getElementById('<%=drplocation.ClientID %>').disabled=false;

            if (document.getElementById('<%= routeBlock1.ClientID %>').style.display == "block") {
                startTag = "<br/><TABLE ID='tabDrg1' Cellpadding='4' Cellspacing='0' Border='1px' style='BackgroundColor:#ff6600;border-collapse:collapse;' ><tr style='height:20px;'><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Select_1 %>"+" </td><td style='width:220px;'  > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_DrugName_1 %>"+" </td><td style='width:120px;display:none;'  > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Dose_1 %>"+"  </td><td style='width:80px;'  > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Route %>"+" </td> <td style='width:80px;'  >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Frequency_1 %>"+" </td><td style='width:180px;'  >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Direction_1 %>"+" </td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Duration_1 %>"+" </td><td style='width:50px;' > Qty </td><td style='width:150px;' > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Instruction_1 %>"+"  </td><td></td> </tr>";
                endTag = "</TABLE>";
            }
            else {
                startTag = "<br/><TABLE ID='tabDrg1' Cellpadding='4' Cellspacing='0' Border='1px' style='BackgroundColor:#ff6600;border-collapse:collapse;' ><tr style='height:20px;'><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Select_2 %>"+"</td><td style='width:220px;'  > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_DrugName_2 %>"+" </td><td style='width:120px;display:none;'  > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Dose_2 %>"+"</td> <td style='width:80px;'  > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Frequency_2 %>"+" </td><td style='width:180px;'  >  "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Direction_2 %>"+" </td><td > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Duration_2 %>"+" </td><td style='width:50px;' > Qty </td><td style='width:150px;' > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_Instruction_2%>"+" </td><td></td> </tr>";
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
                            if (arrayChildData[0] == "DDOSE") {
                                Dose = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "ROA") {
                                Route = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "FRQ") {
                                Frequency = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "DIR") {
                                Direction = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "DURA") {
                                Duration = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "INS") {
                                Instruction = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "PID") {
                                ProductID = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "AutoID") {
                                AutoID = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "TaskID") {
                                TaskID = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "Qty") {
                                Qty = arrayChildData[1];
                            }
                        }
                    }
                    var chkBoxName = "RID^" + 0 + "~DNAME^" + DrugName + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency +"~DIR^" + Direction + "~DURA^" + Duration + "~INS^" + Instruction +  "~PID^" + ProductID  + "~AutoID^" + AutoID + "~TaskID^" + TaskID + "~Qty^" + Qty +""; 
                    var ReturnYesOrNo = DeletedValueCheck(chkBoxName);
                    if (ReturnYesOrNo == "Yes") {
                        newTable += "<TR><TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency + "~DIR^" + Direction +"~DURA^" + Duration + "~INS^" + Instruction + "~PID^" + ProductID + "~AutoID^" + AutoID + "~TaskID^" + TaskID +  "~Qty^" + Qty +"' onclick='chkUnCheck(name);'  type='checkbox' /> "
                    + "</TD><TD style=\"WIDTH: 120px\" >" + DrugName + "</TD>";
                    }
                    else {
                        newTable += "<TR><TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency +"~DIR^" + Direction + "~DURA^" + Duration + "~INS^" + Instruction + "~PID^" + ProductID + "~AutoID^" + AutoID + "~TaskID^" + TaskID +  "~Qty^" + Qty +"' onclick='chkUnCheck(name);'  type='checkbox' checked='checked' />"
                    + "</TD><TD style=\"WIDTH: 220px\" >" + DrugName + "</TD>";
                    }
//                   newTable += "<TD style=\"WIDTH: 120px\" >" + Dose + "</TD>";
                    if (document.getElementById('<%= DoseBlock1.ClientID %>').style.display == "block") {
                        newTable += newTable += "<TD style=\"WIDTH: 120px\" >" + Dose + "</TD>";
                    }
                    if (document.getElementById('<%= routeBlock1.ClientID %>').style.display == "block") {
                        newTable += "<TD style=\"WIDTH: 120px\" >" + Route + "</TD>";
                    }
                    newTable += "<TD style=\"WIDTH: 80px\" nowrap='nowrap'>" + Frequency + "</TD>";
                    newTable += "<TD style=\"WIDTH: 180px\" nowrap='nowrap'>" + Direction + "</TD>";
                    newTable += "<TD >" + Duration + "</TD>";
                    newTable += "<TD >" + Qty + "</TD>";
                    newTable += "<TD style=\"WIDTH: 150px\" >" + Instruction + "</TD>";
                    newTable += "<TD><input name='RID^" + 0 + "~DNAME^" + DrugName + "~DDOSE^" + Dose + "~ROA^" + Route + "~FRQ^" + Frequency + "~DIR^" + Direction +"~DURA^" + Duration + "~INS^" + Instruction + "~PID^" + ProductID + "~AutoID^" + AutoID + "~TaskID^" + TaskID + "~Qty^" + Qty +"' onclick='btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_InventoryAdvice_EDIT_1 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
                 // document.getElementById('<%=drplocation.ClientID %>').disabled=true;
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
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase())
                 {
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
        var arrayDose = new Array();
        var arrayRoute = new Array();
        var arrayFrequency = new Array();
        var arrayDirection = new Array();
        var arrayDuration = new Array();
        var arrayDurationDaysCount = new Array();
        var arrayInstruction = new Array();
        var arrayProductID = new Array();
        var arrayAutoID = new Array();
        var arrayTaskID = new Array();
        var arrayQty = new Array();
        arrayGotValue = sEditedData.split('~');
       
        var DrugName,  Dose, Route, Frequency,Direction, Duration, Instruction,ProductID,AutoID,TaskID,Qty;

        
        if (arrayGotValue.length > 0) {
            DrugName = arrayGotValue[1];
            Dose = arrayGotValue[2];
            Route = arrayGotValue[3];
            Frequency = arrayGotValue[4];
            Direction = arrayGotValue[5];
            Duration = arrayGotValue[6];
            Instruction = arrayGotValue[7];
            ProductID = arrayGotValue[8];
            AutoID=arrayGotValue[9];
            TaskID=arrayGotValue[10];
            Qty=arrayGotValue[11];
            arrayDrugName = DrugName.split('^');

            arrayDose = Dose.split('^');
            arrayRoute = Route.split('^');
            arrayFrequency = Frequency.split('^');
            arrayDirection = Direction.split('^');
            arrayDuration = Duration.split('^');
            arrayInstruction = Instruction.split('^');
            arrayProductID = ProductID.split('^');
            arrayAutoID =  AutoID.split('^');
            arrayTaskID =  TaskID.split('^');
            arrayQty =  Qty.split('^');
            var blnInstructionExists = false;
            var blnOtherInstruction = false;
            var resultInstruction;
            var ddlInsValue;
            

            var HidInstruction = document.getElementById('<%= hdnInstruction.ClientID %>').value;
            var Instructionlist = HidInstruction.split('^');
          
            
            for (var count = 0; count < Instructionlist.length; count++) {

                if (Instructionlist[count] == arrayInstruction[1]) {

                    ddlInsValue = arrayInstruction[1];
                    blnInstructionExists = true;
                    document.getElementById('<%= txtINS.ClientID %>').style.display = "block";
                    
                }
            }

            if (!blnInstructionExists) {

                if (arrayInstruction[1] != "") {
                    resultInstruction = arrayInstruction[1];
                    ddlInsValue = "Other";
                    blnOtherInstruction = true;
                   
                }
            }

        }
        var Instructionlists=arrayInstruction[1].split('-');
        if(Instructionlists.length>1)
        {
        ddlInsValue=Instructionlists[0];
        resultInstruction=Instructionlists[1];
        }

        if (arrayDrugName.length > 0) {
            document.getElementById('<%= tDName.ClientID %>').value = arrayDrugName[1];
        }

        if (arrayDose.length > 0) {
            document.getElementById('<%= tDose.ClientID %>').value = arrayDose[1];
        }

        if (arrayRoute.length > 0) {
            document.getElementById('<%= tROA.ClientID %>').value = arrayRoute[1];
        }
        if (arrayProductID.length > 0) {
            document.getElementById('<%= hdnProductID.ClientID %>').value = "(ProdID:" + arrayProductID[1] + ")";
        }
         if (arrayAutoID.length > 0) {
         document.getElementById('<%= hdnAutoID.ClientID %>').value = arrayAutoID[1] ;
        }
         if (arrayTaskID.length > 0) {
         document.getElementById('<%= hdnTaskID.ClientID %>').value = arrayTaskID[1] ;
        }
//        if (arrayFrequency.length > 0) {
//            document.getElementById('<%= tFRQ.ClientID %>').value = arrayFrequency[1];
//            document.getElementById('<%= ddFrequency.ClientID %>').value = arrayFrequency[1];
//        }
        if (arrayFrequency.length > 0) {
            document.getElementById('<%= tFRQ.ClientID %>').value = arrayFrequency[1];
            document.getElementById('<%= ddFrequency.ClientID %>').value = arrayFrequency[1];
            if(document.getElementById('<%= ddFrequency.ClientID %>').value=='')
            {
            document.getElementById('<%= ddFrequency.ClientID %>').value='-Others-';
            document.getElementById('<%= tFRQ.ClientID %>').style.display = "block";
            document.getElementById('<%= tFRQ1.ClientID %>').style.display = "block";
            document.getElementById('<%= tFRQ.ClientID %>').value = arrayFrequency[1];
            }
            else
            {
            document.getElementById('<%= tFRQ.ClientID %>').style.display = "none";
            document.getElementById('<%= tFRQ1.ClientID %>').style.display = "none";
            }
        }
        if (arrayDirection.length > 0) {
            document.getElementById('<%= ddDirection.ClientID %>').value = arrayDirection[1];
        }
        if (arrayQty.length > 0) {
            document.getElementById('<%= txtQty.ClientID %>').value = arrayQty[1];
        }
        if (arrayInstruction.length > 0) {
           
            document.getElementById('<%= ddlInstruction.ClientID %>').value = ddlInsValue;
//            document.getElementById('<%= txtINS.ClientID %>').style.display = "block";
        }
        if (blnOtherInstruction) {
            document.getElementById('<%= txtINS.ClientID %>').style.display = "block";
            document.getElementById('<%= txtINS.ClientID %>').value = resultInstruction;
        }
        if (arrayDuration.length > 0) {
            arrayDurationDaysCount = arrayDuration[1].split(' ');
            if (arrayDurationDaysCount.length > 0) {
                document.getElementById('<%= txtFrequencyNumber.ClientID %>').value = arrayDurationDaysCount[0];
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

                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == (arrayDrugName[1].toLowerCase())) {
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
        
        var ddFreq = arrayFrequency[1];
        var Direction = document.getElementById('<%= hdnDirection.ClientID %>').value.split('^');
        for (var i = 0; i < Direction.length - 1; i++) {
            var item = Direction[i].split('~');
            if(ddFreq==item[0])
            {
                document.getElementById('<%= ddDirection.ClientID %>').value=item[1];
                document.getElementById('<%= hdnDrugcalculation.ClientID %>').value=item[2];
            }
        }
       //CreateJavaScriptTables();
    }
  
</script>

<asp:HiddenField ID="hdfDrugs" runat="server" />
<asp:HiddenField ID="hdnDrugNameExists" runat="server" />
<asp:HiddenField ID="hdnDrugsDeleted" runat="server" />
<asp:HiddenField ID="hdnInstruction" runat="server" />
<asp:HiddenField ID="hdnDirection" runat="server" />
<asp:HiddenField ID="hdnDrugcalculation" runat="server" />
<asp:HiddenField ID="hdnDrugcalculationother" runat="server" />
<asp:HiddenField ID="hdnInvtaskStatusID" runat="server" Value="0" />
<asp:HiddenField ID="hdnINVTaskID" runat="server" Value="0" />
<asp:HiddenField ID="hdnPrescribedrugexpiryDate" runat="server" />
<asp:HiddenField ID="hdnPreviousDrugList" runat="server" />
<asp:HiddenField ID="hdninvlocationID" runat="server" />
<asp:HiddenField ID="hdnOnBehalfID" runat="server" />
<asp:HiddenField ID="hdnIsCorpOrg" runat="server" />
<asp:HiddenField ID="hdnVid" runat="server" />

<script language="javascript" type="text/javascript">
    CreateJavaScriptTables();
</script>

