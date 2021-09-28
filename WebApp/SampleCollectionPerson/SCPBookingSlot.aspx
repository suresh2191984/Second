<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SCPBookingSlot.aspx.cs" Inherits="SampleCollectionPerson_SCPBookingSlot" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"  TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="~/SampleCollectionPerson/Controls/SPBookingSlot.ascx" TagName="Schd" TagPrefix="SCPBooking" %>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>SCP Booking Slot Selection</title>
    <script src="../../Scripts/Common.js" type="text/javascript"></script>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
   <link href="../PlatForm/StyleSheets/jquery-ui.css" rel ="Stylesheet" type ="text/css" />
   
  <script type="text/javascript">
   
// $(document).ready(function () {
//  
//   $("input[id*=lblvalue]").text("SCP Booking Slot Selection");
//    });
    
    
   function onConfirmBookingSlot(){   
   
  
        var gblBookingDate ="";
        var gblResourceID="";
        var gblSlot ="";
        var gblpincode="";
        var gblResourceName ="";
    
       gblBookingDate = $("input[id*=hdngblBookingDate]").val();
       gblResourceID = $("input[id*=hdngblResourceID]").val();
       gblSlot = $("input[id*=hdngblSlot]").val();
       gblpincode = $("input[id*=hdngblpincode]").val(); 
       gblResourceName = $("input[id*=hdnTechName]").val(); 


if (gblResourceID != ""){
    
   if (confirm("Are you sure you Booking the selected slot?")) 
        {
          if (gblResourceID != ""){
          
             window.location = "../HomeCollection/homecollection.aspx?TechID=" + gblResourceID + "&BkDate=" + gblBookingDate + "&Hours=" + gblSlot + "&PinCode=" + gblpincode + "&TechName=" + gblResourceName + ""
          }
        
        }
   
   
   }else{
    alert("Please Select Slot.")
   
   }
   
   }
   
  
   </script> 
</head>
<body>
     <form id="form1" runat="server">
      <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ScriptManager>
    <div id="wrapper">
       <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <asp:UpdatePanel ID="ll" runat="server">
                <ContentTemplate>
        <div class="contentdata">
           
    <SCPBooking:Schd ID="spBooking" runat="server" />
     
      <table width="100%" border="0" cellpadding="4" cellspacing="0" class="dataheader3">
      <tr>
        <td style="width: 15%">
            <br />
        </td>
        <td style="width: 15%">
           
        </td>
        <td style="width: 15%">
           
        </td>
        <td style="width: 15%">
           
        </td>
        <td style="width: 40%">
        </td>
    </tr>
      <tr id="tr2">
   
        <td colspan="6" align="center" >
         <input type="button" id="btnCreate" value="Create Booking" onclick="javascript:onConfirmBookingSlot();"  />
<%--            <input type="button" id="btnCancel" value="Cancel" onclick="javascript:onClickCancel();" />--%>
               </td>
       
    </tr></table>
    </div>
     </ContentTemplate>
      </asp:UpdatePanel>
     
         <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>
</body>
</html>
