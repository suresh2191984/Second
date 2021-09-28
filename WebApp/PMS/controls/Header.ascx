<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header.ascx.cs" Inherits="PMS_Header" %>
<style>
    .bcmdLink 
    {
     width: 214px;
    padding: 8px 0 0 9px;
    display: block;
    color: #fff!important;
    font-size: 18px;
    font-weight: bold;
    }
</style>
<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
          data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><img width="120" height="25" alt="Brand" src="images/attune_logo_website.png"></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="Home.aspx?FldID=0">Home</a></li>
              
              <%--<li><a href="#">Categories</a></li>
              <li><a href="#">Folders</a></li>
              <li><a href="#">Parameter Queries</a></li>--%>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click" Text="Logout"></asp:LinkButton></li>
            </ul>
          </div>
          <div >
             
            <asp:LinkButton ID="cmdLink" CssClass="bcmdLink" runat="server" Text="<< Back to Admin Role" OnClick="cmdLink_Click">
            </asp:LinkButton>
       </div>

      </div>
    </nav>
