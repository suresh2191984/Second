<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewConsolidateCaseSheet.aspx.cs"
    Inherits="Physician_ViewConsolidateCaseSheet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<%@ Register Src="../DischargeSummary/Musculoskeletal.ascx" TagName="Musculoskeletal"
    TagPrefix="uc6" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  

   
    <style type="text/css">
        .table_wrapper
        {
            width: 800px;
            overflow-x: auto;
            overflow-y:auto;
        }
        .table_inner
        {
            height: 400px;
            
            overflow-y: auto;
            overflow-x:auto;  
            
          
        }
        .tloc
        {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <%-- <table id ="main" runat ="server" >
    <tr>
    <td>--%>
    
    <div class="table_wrapper">
    
    <table width="100%" border="1" cellspacing="0" cellpadding="0">
    <tr>
    <asp:Label ID="lblfreezpane" runat="server"></asp:Label>
    </tr>
    </table>
 
 
    <div class="table_inner">
    <table width="100%" border="1" cellspacing="0" cellpadding="0">
    <tr><td> 
  
     <asp:Label ID="lblbind" runat="server"></asp:Label>
     
     </td>  </tr>
    </table>
    </div></div>
     
    <uc6:Musculoskeletal ID="Musculoskeletal1" runat="server" />
    <uc5:DiagnoseWithICD ID="DiagnoseWithICD1" runat="server" />
    </form>
</body>
</html>
