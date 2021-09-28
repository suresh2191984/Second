<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ComplaintICDCode.ascx.cs"
    Inherits="CommonControls_ComplaintICDCode" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<div id="divwidth">
</div>
<%--<table width="80%" cellpadding="0" cellspacing="0" border="0" class="defaultfontcolor">
    <tr>
        <td >
            <asp:Label ID="lblComplaint" runat="server"></asp:Label>
        </td>
        <td >
            <asp:Label ID="lblICDCode" runat="server" Text="ICD Code"></asp:Label>
        </td>
        <td >
            <asp:Label ID="lblICDName" runat="server" Text="ICD Name"></asp:Label>
        </td>
    </tr>
    <tr>
        <td >
            <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
            <asp:HiddenField ID="hdnCID" runat="server" />
            <asp:HiddenField ID="hdICD" runat="server" />
            <asp:HiddenField ID="hdnFlag" runat="server" />
            <asp:TextBox runat="server" ID="txtCpmlaint" autocomplete="off" OnChange="javascript:GetText(this.value);" TextMode="MultiLine"> </asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtCpmlaint"
                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosisID"
                ServicePath="~/WebService.asmx">
            </AutoCom:AutoCompleteExtender>
        </td>
        <td >
            <asp:TextBox runat="server" ID="txtICDCode" autocomplete="off" OnChange="javascript:GetICDCode(this.value);" TextMode="MultiLine" > </asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtICDCode"
                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDCODE"
                ServicePath="~/WebService.asmx">
            </AutoCom:AutoCompleteExtender>
        </td>
        <td >
            <asp:TextBox runat="server" ID="txtICDName" autocomplete="off" OnChange="javascript:GetICDName(this.value);" TextMode="MultiLine" > </asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtICDName"
                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDName"
                ServicePath="~/WebService.asmx">
            </AutoCom:AutoCompleteExtender>
            <asp:Button ID="btnHistoryAdd" OnClientClick="javascript:return onClickAddComplaint();"
                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            &nbsp;
        </td>
    </tr>
   
</table>--%>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="tbl1" runat="server"
    style="padding-left: 5px;">    
    <tr>
        <td style="width: 16%;" id="tdDesclbl" runat="server">
            <asp:Label ID="lblICDName" runat="server" Text="ICD 10 Description" meta:resourcekey="lblICDNameResource1"></asp:Label>
        </td>
        <td id="tdDescTxt" runat="server">
            <asp:TextBox runat="server" ID="txtICDName" autocomplete="off" OnChange="javascript:GetICDName(this.value);"
                TextMode="MultiLine" Rows="1" meta:resourcekey="txtICDNameResource1" 
                Height="20px"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtICDName"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheelC listMainC .boxC" CompletionListItemCssClass="wordWheelC itemsMainC"
                CompletionListHighlightedItemCssClass="wordWheelC itemsSelectedC" ServiceMethod="getICDName"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td style="width: 16%;">
            <asp:Label ID="lblComplaint" runat="server" meta:resourcekey="lblComplaintResource1"></asp:Label>
        </td>
        <td align="left">
            <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
            <asp:HiddenField ID="hdnCID" runat="server" />
            <asp:HiddenField ID="hdICD" runat="server" />
            <asp:HiddenField ID="hdnFlag" runat="server" />
            <asp:TextBox runat="server" ID="txtCpmlaint" autocomplete="off" OnChange="javascript:GetTextC(this.value);"
                TextMode="MultiLine" Rows="1" meta:resourcekey="txtCpmlaintResource1" Height="20px"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtCpmlaint"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheelC listMainC .boxC" CompletionListItemCssClass="wordWheelC itemsMainC"
                CompletionListHighlightedItemCssClass="wordWheelC itemsSelectedC" ServiceMethod="getDiagnosisID"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
    </tr>
    <tr>
        <td style="width: 16%;" id="tdCodelbl" runat="server">
            <asp:Label ID="lblICDCode" runat="server" Text="ICD 10 Code" meta:resourcekey="lblICDCodeResource1"></asp:Label>
        </td>
        <td id="tdCodeTxt" runat="server">
            <asp:TextBox runat="server" ID="txtICDCode" autocomplete="off" OnChange="javascript:GetICDCode(this.value);"
                TextMode="MultiLine" Rows="1" meta:resourcekey="txtICDCodeResource1" Height="20px"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtICDCode"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheelC listMainC .boxC" CompletionListItemCssClass="wordWheelC itemsMainC"
                CompletionListHighlightedItemCssClass="wordWheelC itemsSelectedC" ServiceMethod="getICDCODE"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
    </tr>
    <tr>
        <td>
            
        </td>
        <td align="left">
            <asp:CheckBox ID="chkIsfirstdiagnosis" runat="server" Text="Is Newly diagnosed" />
            <asp:CheckBox ID="chkPrimary" runat="server" Text="Primary Diagnosis" />
        </td>
    </tr>    
    <tr>
        <td colspan="2" style="padding-left:18%">
            <asp:Button ID="btnHistoryAdd" OnClientClick="javascript:return onClickAddComplaint();"
                runat="server" Text ="Add"  CssClass="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" meta:resourcekey="btnHistoryAddResource1" Width="75px" />
        </td>
    </tr>    
    <tr class="defaultfontcolor">
        <td colspan="2" style="display:block">
            <table id="tblDiagnosisItems" class="gridView" runat="server" cellpadding="4" cellspacing="0" border="1">
            </table>
            <asp:HiddenField runat="server" ID="hdnIcdcode" Value="N"/>
            <asp:HiddenField runat="server" ID="hdnComplaintId" Value="0" />
            <asp:HiddenField runat="server" ID="hdnICDName" Value="" />
            <asp:HiddenField runat="server" ID="hdnComplaint" Value="" />
            <asp:HiddenField runat="server" ID="hdnICDCODE1" Value="" />
        </td>
    </tr>
    
</table>

<script language="vbscript" type="text/vbscript">

	Function vbMsg(isTxt,caption)	
	testVal = MsgBox(isTxt,3,caption)
	ischoice=testval	
	End Function

</script>

<script language="javascript" type="text/javascript">
    var ischoice = 0;
    var IscorpOrg = '<%= isCorporateOrg%>';
    function GetTextC(pCName) {
    
//        //Tuberculosis of lung, without mention of bacteriological or histological confirmation~A16.2~Pulmonary tuberculosis
//        if (pCName != "") {

//            document.getElementById('<%=hdnCID.ClientID %>').value = "";
//            var Temp = pCName.split('~');
//            document.getElementById('<%=hdnCID.ClientID %>').value = 0;

//            if (Temp[1] == undefined) {
//                var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_1');
//                if (userMsg != null) {
//                    alert(userMsg);
//                }
//                else {
//                    vbMsg('No matching ICD 10 code. Are you sure to continue with existing ICD code?', 'Alert Message');
//                }
//                //6(yes) 7(No) 2(Cancel)
//                if (ischoice == 6) {

//                    onClickAddComplaint();  //newly added 

//                }
//                else if (ischoice == 7) {
//                    document.getElementById('<%=txtICDCode.ClientID %>').value = "";
//                    document.getElementById('<%=txtICDName.ClientID %>').value = "";
//                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";//newly added 

//                  
//                }
//                else {

//                    //document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";//newly commented 
//                }

//            }
//            else {

//                document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];
//                //document.getElementById('<%=hdnCID.ClientID %>').value = 0;
//              //  document.getElementById('<%=txtICDCode.ClientID %>').value = "";
//               // document.getElementById('<%=txtICDName.ClientID %>').value = "";

//            }


//        }
  if (pCName != "") {    
        var Check='Y';        
         var Temp = pCName.split('~');                    
         if(document.getElementById('<%=hdnComplaintId.ClientID %>').value !="0"  && document.getElementById('<%=hdnComplaintId.ClientID %>').value !="-1")
             {
              if(Temp[3]!=undefined){ 
                if(document.getElementById('<%=hdnComplaintId.ClientID %>').value!=Temp[3] && Temp[3]>0){
                    if(confirm("Are You sure to change with existing Diagnose?")){  
                            window.location.href("../Physician/PatientDiagnose.aspx?id="+Temp[3]); 
                            Check='N';                       
                       }
                       else{
                        document.getElementById('<%=txtCpmlaint.ClientID %>').value=document.getElementById('<%=hdnComplaint.ClientID %>').value; 
                        Check='N';                       
                       }
                 }
               }
             }   
             
           if(Check=='Y'){     
            document.getElementById('<%=hdnCID.ClientID %>').value = "";                     
            document.getElementById('<%=hdnCID.ClientID %>').value = 0;
               if (Temp[1] == undefined)
                {             
                    if(confirm('No matching ICD 10 code. Are you sure to continue with existing ICD code?'))
                    {
                      onClickAddComplaint()
                    }
                    else
                    {
                        document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                        document.getElementById('<%=txtICDName.ClientID %>').value = "";
                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
                     }
               }
                else
                {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];
                    document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];            
                    document.getElementById('<%=txtICDName.ClientID %>').value = Temp[2];                                            
                }
          }
        }
    }
      
       function GetICDCode(pICDName) {
    
//        if (pICDName != "") {
//            document.getElementById('<%=hdICD.ClientID %>').value = "";

//            var Temp = pICDName.split('~');
//            document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
//            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];

//            if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "") {
//                var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_2');
//                if (userMsg != null) {
//                    alert(userMsg);
//                }
//                else {
//                    vbMsg('Are you  sure to continue with existing Diagnose', 'Alert Message');
//                }

//                //6(yes) 7(No) 2(Cancel)
//                if (ischoice == 6) {
//                    document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
//                    
//                }
//                else if (ischoice == 7) {

//                    document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
//                    if (Temp[2] != "") {
//                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
//                    }
//                    else {
//                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[1];

//                    }
//                }
//                else {
//                    document.getElementById('<%=txtICDCode.ClientID %>').value = "";
//                    document.getElementById('<%=txtICDName.ClientID %>').value = "";
//                }


//            }

//            else if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value == "") {
//                document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
//                if (Temp[2] != "") {
//                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
//                }
//                else {
//                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[1];

//                }
//            }

//            //This else if used for user defined icd codes 

//            else if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {

//             document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
//              //  document.getElementById('<%=txtICDName.ClientID %>').value = "";
//                //document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
//            }
//       
//           

//        }
//    }

       if (pICDName != "") {
            var Temp = pICDName.split('~');
            var Check='Y';
         if(document.getElementById('<%=hdnComplaintId.ClientID %>').value !="0"  && document.getElementById('<%=hdnComplaintId.ClientID %>').value !="-1")
             {
              if(Temp[3]!=undefined){ 
                if(document.getElementById('<%=hdnComplaintId.ClientID %>').value!=Temp[3] && Temp[3]>0){
                    if(confirm("Are You sure to change with existing Diagnose?")){  
                            window.location.href("../Physician/PatientDiagnose.aspx?id="+Temp[3]);                         
                            Check='N';
                       }
                       else{
                       document.getElementById('<%=txtICDCode.ClientID %>').value=document.getElementById('<%=hdnICDCODE1.ClientID %>').value; 
                        Check='N';
                       }
                 }
               }
             }   
           if(Check=='Y'){            
            document.getElementById('<%=hdICD.ClientID %>').value = "";           
            document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];
            
            if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "") 
            {
             if((document.getElementById('<%=hdnComplaintId.ClientID %>').value =="0")  || (document.getElementById('<%=hdnComplaintId.ClientID %>').value=="-1"))
              {
                if(confirm('Are you  sure to continue with existing Diagnose'))
                 {
                  document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];                                            
                 }                    
                 else
                 {
                   document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
                   if (Temp[2] != "") {
                      document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
                    }
                    else {
                     document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[1];
                    }
                 }
              }
            else{
              document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];   
            } 
          }
         else if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value == "") 
         {
          document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
           if (Temp[2] != "") {
               document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
            }
            else {
               document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[1];
                }
         }
            //This else if used for user defined icd codes 
        else if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {
         document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];          
        }
       
      }
    }
 }

    function GetICDName(pICDCode) {
    
//        if (pICDCode != "") {

//          
//            document.getElementById('<%=hdICD.ClientID %>').value = "";
//            var Temp = pICDCode.split('~');
//            document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];
//            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];

//            if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "") {
//                var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_2');
//                if (userMsg != null) {
//                    alert(userMsg);
//                }
//                else {
//                    vbMsg(' Are You  sure to continue with existing Diagnose', 'Alert Message');
//                }

//                //6(yes) 7(No) 2(Cancel)
//                if (ischoice == 6) {
//                    document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
//                }
//                else if (ischoice == 7) {

//                    document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];

//                    if (Temp[2] != "") {
//                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
//                    }
//                    else {
//                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];

//                    }
//                }
//                else {
//                    document.getElementById('<%=txtICDCode.ClientID %>').value = "";
//                    document.getElementById('<%=txtICDName.ClientID %>').value = "";
//                }


//            }

//            else if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value == "") {
//                document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
//                if (Temp[2] != "") {
//                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
//                }
//                else {
//                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];

//                }
//            }
//            else if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {

//           // document.getElementById('<%=txtICDCode.ClientID %>').value = "";
//            document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];
//               // document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
//            }

////this else if used for used defined iCD codes //

////            else if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value == "undefined")) {

////                document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
////                document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
////                document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
////            }

//        }
//    }
 if (pICDCode != "") {
           var Check='Y';
                      
           var Temp = pICDCode.split('~');
            
           if(document.getElementById('<%=hdnComplaintId.ClientID %>').value !="0"  && document.getElementById('<%=hdnComplaintId.ClientID %>').value !="-1")
             {
              if(Temp[3]!=undefined){ 
                if(document.getElementById('<%=hdnComplaintId.ClientID %>').value!=Temp[3] && Temp[3]>0){
                    if(confirm("Are You sure to change with existing Diagnose?")){  
                            window.location.href("../Physician/PatientDiagnose.aspx?id="+Temp[3]); 
                            Check='N';                        
                       }
                        else{
                       document.getElementById('<%=txtICDName.ClientID %>').value=document.getElementById('<%=hdnICDName.ClientID %>').value; 
                       Check='N';                         
                       }
                 }
               }
               
             }   
           if(Check=='Y'){         
            document.getElementById('<%=hdICD.ClientID %>').value = "";           
            document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];                   
                               
           if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "")
            {
               if((document.getElementById('<%=hdnComplaintId.ClientID %>').value =="0")  || (document.getElementById('<%=hdnComplaintId.ClientID %>').value=="-1"))
               {
                  if(confirm('Are You  sure to continue with existing Diagnose')) 
                   {
                     document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];                                            
                   }                    
                  else
                  {
                     document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
                  
                     if (Temp[2] != "")
                      {
                       document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
                      }
                     else {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];
                    }
                 }
               }
               else{
                 document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
               }           
            }
            else if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value == "") 
            {
               document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
                if (Temp[2] != "") {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
                }
                else {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];

                }
            }
            else if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {        
                document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];             
            }
        }
      }
    }
    
    function onClickAddComplaint() {
    
        if (document.getElementById('<%=txtCpmlaint.ClientID %>').value.trim() == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert("Enter medical problem");
            }
            return false;
        }
        if (document.getElementById('<%=hdnIcdcode.ClientID %>').value == "Y") {
            if (document.getElementById('<%=txtCpmlaint.ClientID %>').value.trim() == "" || document.getElementById('<%=txtICDCode.ClientID %>').value.trim() == "" || document.getElementById('<%=txtICDName.ClientID %>').value.trim() == "") {
                alert('Enter ICD Details');
                return false;
            }
        }
        var rwNumber = parseInt(110);
        var AddStatus = 0;
        var ComplaintName = document.getElementById('<%=txtCpmlaint.ClientID %>').value.trim();
        var ComplaintID = document.getElementById('<%=hdnCID.ClientID %>').value.trim();
        var ICDCODE = document.getElementById('<%=txtICDCode.ClientID %>').value.trim();
        var ICDName = document.getElementById('<%=txtICDName.ClientID %>').value.trim();
        var PrimaryDiagnosed = "";
        var Pdiagnosedtext = "";
        var Isfirstdiagnosis = "";
        var Isfirst = '';
        if (document.getElementById('<%=chkIsfirstdiagnosis.ClientID %>').checked == true) {
            Isfirstdiagnosis = "Is Newly diagnosed";
            Isfirst = '1';
        }
      if (document.getElementById('<%=chkPrimary.ClientID %>').checked == true) {
            document.getElementById('<%=chkPrimary.ClientID %>').disabled = true;
            PrimaryDiagnosed = 'Y';
            Pdiagnosedtext = 'Primary Diagnosis';
        }
        else {
            PrimaryDiagnosed = 'N';
            Pdiagnosedtext = 'Secondary Diagnosis';
        }
        document.getElementById('<%=tblDiagnosisItems.ClientID %>').style.display = 'block';

        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;
        var list = HidValue.split('^');
        if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var CList = list[count].split('~');
                if (CList[1] != '') {
                    if (CList[0] != '') {
                        rwNumber = parseInt(parseInt(CList[0]) + parseInt(1));
                    }
                    if (ComplaintName != '') {
                        if (CList[1] == ComplaintName) {

                            AddStatus = 1;
                            document.getElementById('<%=tblDiagnosisItems.ClientID %>').style.display = 'block'; 
                        }
                    }
                }
            }
        }
        else {

            if (ComplaintName != '') {
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);                
                var cell3 = row.insertCell(2);                
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
				var cell7 = row.insertCell(6);
                if (IscorpOrg == 'Y') {
                    cell3.style.display = "none";
                    cell4.style.display = "none";
                }              
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ComplaintName;
                cell3.innerHTML = ICDCODE;
                cell4.innerHTML = ICDName;
                cell5.innerHTML = Isfirstdiagnosis;
  				cell6.innerHTML = Pdiagnosedtext;
                cell7.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + Isfirst +  "~" + PrimaryDiagnosed + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + Isfirst + "~" + PrimaryDiagnosed + "^";
                AddStatus = 2;
            }
        }

        if (AddStatus == 0) {
            if (ComplaintName != '') {
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);                
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                if (IscorpOrg == 'Y') {
                    cell3.style.display = "none";
                    cell4.style.display = "none";
                }
             
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ComplaintName;
                cell3.innerHTML = ICDCODE;
                cell4.innerHTML = ICDName;
                cell5.innerHTML = Isfirstdiagnosis;
                cell6.innerHTML = Pdiagnosedtext;
                cell7.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + Isfirst + "~" + PrimaryDiagnosed + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + Isfirst + "~" + PrimaryDiagnosed + "^";
            }
        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_4');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert("Complaint Already Added!");
        }
		if (document.getElementById('<%=chkPrimary.ClientID %>').checked == true) {
                document.getElementById('<%=chkPrimary.ClientID %>').disabled = false;
            }
        }
        document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
        document.getElementById('<%=txtICDCode.ClientID %>').value = "";
        document.getElementById('<%=txtICDName.ClientID %>').value = "";
        document.getElementById('<%=chkIsfirstdiagnosis.ClientID %>').checked = false;
        document.getElementById('<%=hdnFlag.ClientID %>').value = "";
        document.getElementById('<%=chkPrimary.ClientID %>').checked = false;

        return false;

    }

    function ImgOnclickComplaint(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;
        var list = HidValue.split('^');
        var newCList = '';
        if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var CList = list[count].split('~');
                if (CList[0] != '') {
                    if (CList[0] != ImgID) {
                        newCList += list[count] + '^';
                    }

                    if (CList[0]== ImgID && CList[6] == "Y") {
                        document.getElementById('<%=chkPrimary.ClientID %>').disabled = false;
                    }
                }
            }
            document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value = newCList;
        }
        if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value == '') {
            document.getElementById('<%=tblDiagnosisItems.ClientID %>').style.display = 'none';
        }
    }




    function LoadComplaintItems() {
        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;

        var list = HidValue.split('^');

        while (count = document.getElementById('<%=tblDiagnosisItems.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblDiagnosisItems.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblDiagnosisItems.ClientID %>').deleteRow(j);

            }
        }
        if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var CList = list[count].split('~');
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = CList[0];
                var rwNumber = CList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);                
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                if (IscorpOrg == 'Y') {
                    cell3.style.display = "none";
                    cell4.style.display = "none";
                } 
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = CList[1];
                cell3.innerHTML = CList[3];
                cell4.innerHTML = CList[4];
                var CLists = '';
                if (CList[5] == '1') {
                    CLists = 'Is Newly diagnosed';
                }
                cell5.innerHTML = CLists;
                if (CList[6] == 'Y') {
                    document.getElementById('<%=chkPrimary.ClientID %>').disabled = true;
                    CLists = 'Primary Diagnosis';
                }
                else {
                    CLists = 'Secondary Diagnosis';
                }

                cell6.innerHTML = CLists;
                // cell6.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + CList[1] + "~" + CList[2] + "~" + CList[3] + "~" + CList[4] + "~" + CList[5] + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                cell7.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + CList[1] + "~" + CList[2] + "~" + CList[3] + "~" + CList[4] + "~" + CList[5] + "~" + CList[6] + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";

            }
        }
    }


    function btnEditC_OnClick(sEditedData) {


        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;

        arrayAlreadyPresentDatas = tempDatas.split('^');
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
                tempDatas += arrayAlreadyPresentDatas[iCount] + "^";

            }
        }

        var arrayGotValue = new Array();

        arrayGotValue = sEditedData.split('~');


        if (arrayGotValue.length > 0) {

            document.getElementById('<%=hdnCID.ClientID %>').value = arrayGotValue[2];
            document.getElementById('<%=txtCpmlaint.ClientID %>').value = arrayGotValue[1];
            document.getElementById('<%=txtICDCode.ClientID %>').value = arrayGotValue[3];
            document.getElementById('<%=txtICDName.ClientID %>').value = arrayGotValue[4];
            if (arrayGotValue[5].trim() != '') {
                document.getElementById('<%=chkIsfirstdiagnosis.ClientID %>').checked = true;
            }
            if (arrayGotValue[6].trim() == 'Y') {
                document.getElementById('<%=chkPrimary.ClientID %>').checked = true;
                document.getElementById('<%=chkPrimary.ClientID %>').disabled = false;

            }
        }

        document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value = tempDatas;
        LoadComplaintItems();
    }


    function validationICDCode() {
        document.getElementById('<%=tblDiagnosisItems.ClientID %>').style.display = 'block';
        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;
        if (HidValue == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('Provide the ICD Code');
            }
            document.getElementById('<%=txtICDName.ClientID %>').focus();
            return false;
        }

    }
   
        
</script>

