<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OPCaseSheet.ascx.cs" Inherits="CommonControls_OPCaseSheet" %>
<%@ Register Src="../Investigation/BioChemistryDisplay.ascx" TagName="BioChemistry"
    TagPrefix="uc6" %>
<%@ Register Src="../Investigation/ClinicalDisplay.ascx" TagName="ClinicalDisplay"
    TagPrefix="uc7" %>
<%@ Register Src="../Investigation/HemotologyDisplay.ascx" TagName="HemotologyDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../Investigation/MicroBioDiplay.ascx" TagName="MicroBioDiplay"
    TagPrefix="uc9" %>
<%@ Register Src="Advice.ascx" TagName="Advice" TagPrefix="uc12" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Src="InvestigationReportViewer.ascx" TagName="InvestigationReportViewer"
    TagPrefix="uc2" %>
    <%--  <script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>--%>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />


<%--<script type="text/javascript">
 
    //avoid conflict with other script
    $j=jQuery.noConflict();
 
    $j(document).ready(function($) {
 
	//this is the floating content
	var $floatingbox = $('#floating-box');
 
	if($('#body').length > 0){
 
	  var bodyY = parseInt($('#body').offset().top) - 20;
	  var originalX = $floatingbox.css('margin-left');
 
	  $(window).scroll(function () { 
 
	   var scrollY = $(window).scrollTop();
	   var isfixed = $floatingbox.css('position') == 'fixed';
 
	   if($floatingbox.length > 0){
 
	      $floatingbox.html("srollY : " + scrollY + ", bodyY : " 
                                    + bodyY + ", isfixed : " + isfixed);
 
	      if ( scrollY > bodyY && !isfixed ) {
			$floatingbox.stop().css({
			  position: 'fixed',
			  left: '50%',
			  top: 20,
			  marginLeft: -500
			});
		} else if ( scrollY < bodyY && isfixed ) {
		 	  $floatingbox.css({
			  position: 'relative',
			  left: 0,
			  top: 0,
			  marginLeft: originalX
		});
	     }		
	   }
       });
     }
  });
</script>
--%>
<style type="text/css">
	#floating-box{
		width:90px;
		height:200px;
		border:1px solid red;
		background-color:#BBBBBB;
		float:left;
		margin-left:-100px;
		margin-right:10px;
		position:absolute;
		z-index:1;
	}
	#page{
		width:200px;
    	margin:0 auto;
	}
	#header1{
		
		height:100px;
		margin:8px;
	}
	#body{
		
		height:650px;
		margin:8px;
	}
	#footer1{
		
		height:80px;
		margin:8px;
	}
	h1,h2{
		padding:16px;
	}
</style>
<div id="header1">
<table width ="100%" border ="0">
  <tr>
        <td colspan="9" align="center">
            <asp:Image ID="imgBillLogo" runat="server" Visible="false" 
                 />
        </td>
    </tr>
    <tr>
        <td colspan="9" align="center">
           <font color="Purple">
           <asp:Label  id="lblHospitalName" runat="server" Visible ="false" Font-Bold ="true" font-size="12"  >
           </asp:Label>
           </font> 
        </td>
    </tr>
</table>
</div> 
<div id="body">
<table cellspacing="1" style="height:auto" width="100%" border="0" id="tblCaseSheet"
    runat="server">
  
    <tr>
    </tr>
    <tr align="center" valign="top">
        <td>
            <asp:Label ID="lblPrescription" CssClass="defaultfontcolorCaseSheet" runat="server"
               ></asp:Label>
        </td>
    </tr>
  
</table>
</div> 
<div id="footer1">
<table width ="100%">
   <tr>
        <td align="center">
         <font color="Red">
           <asp:Label  id="lblFooter" runat="server" Visible ="false"  Font-Bold ="true" font-size="12">
           </asp:Label>
           </font> 
        </td>
        </tr>
        <tr>
         <td align="center" >
         <font size="4" face="French Script MT" color="Purple">
         <asp:Label  id="lblmoto" runat="server" Visible ="false" Font-Bold ="true"  >
           </asp:Label>

             </font>
          
        </td>
    </tr> 
</table>
</div> 
<%--<div id="DBio"  runat="server" visible="false">
     
    <div id="bioChemistry" runat="server" >
    <uc6:BioChemistry ID="BioChemistry1" runat="server" />
    </div>
</div>
<div id="DMicro" runat="server" visible="false">

    <div id="Div1" runat="server" >
    <uc9:MicroBioDiplay ID="MicroBioDiplay1" runat="server" Name="Micro" />
    </div>
</div>
<div id="DClinic" runat="server" visible="false" >

    <div id="Div2" runat="server" >
    <uc7:ClinicalDisplay ID="ClinicalDisplay1" runat="server" name="Clinical" />
    </div>
</div>
<div id="DHemat"  runat="server" visible="false">
    <div id="Div3" runat="server" >
    <uc8:HemotologyDisplay ID="HemotologyDisplay1" runat="server" name="Hemo" />
    </div>
</div>--%>
<%--<div id="DHemat"  runat="server">
    <div id="Div3" runat="server" >
        <uc2:InvestigationReportViewer ID="InvestigationReportViewer1" runat="server" Visible="false" />
    </div>
</div>--%>