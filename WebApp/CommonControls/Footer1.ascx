<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Footer1.ascx.cs" Inherits="CommonControls_Footer1" %>
<%@ Register Src="FeedbackControl.ascx" TagName="Feedback" TagPrefix="FB" %>
<table class="w-100p">
        <tr>
            <td class="copyrights">
       <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td>
       <table border="0" cellpadding="0" cellspacing="0" width="100%"  >
       <tr>
       <td >
            <asp:label id="label1" runat="server"  font-names="times new roman" 
                                        text="Powered By" font-size="X-Large" font-bold="true" ></asp:label>
       </td>
       </tr>
       <tr>
       <td >
       <asp:image ID="Image2" runat="server" imageurl="~/images/logo/attunelogo.png" />
       </td>
      
     <%--  <div >
       <table style="background-color:#FFFAFA">
       <tr>
       <td >
     <a><asp:label id="lbldisclaimer" runat="server"  font-names="times new roman" 
                                        text="Disclaimer" font-size="medium" font-bold="true" ></asp:label></a>
      <asp:label id="lbldisclaimer" runat="server"  font-names="times new roman" 
                                        text="Disclaimer" font-size="medium" font-bold="true" ></asp:label>
       </td>
       </tr>
       <tr>
       <td>
       <asp:label id="lbltext" runat="server"  font-names="times new roman" 
                                        text="Page will get refreshed in 10 seconds to home screen" font-size="medium" font-bold="true" ></asp:label>
       </td>
       </tr>
       </table>
       </div>--%>
       </td>
       </tr>
       </table>
       </td>
       </tr>
       </table>
      
    </div>