<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Corporate.ascx.cs" Inherits="CommonControls_Corporate" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
    
  <%--<script type="text/javascript" src="../Scripts/jquery.min.js" language="javascript"></script>

<script type="text/javascript" src="../Scripts/ddaccordion.js" language="javascript"></script>
<script type="text/javascript" src="../scripts/menu.js" language="javascript"></script>
--%>

<%--<script type="text/javascript">


    ddaccordion.init({
        headerclass: "silverheader", //Shared CSS class name of headers group
        contentclass: "submenu", //Shared CSS class name of contents group
        revealtype: "mouseover", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
        mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
        collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
        defaultexpanded: [0], //index of content(s) open by default [index1, index2, etc] [] denotes no content
        onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
        animatedefault: false, //Should contents open by default be animated into view?
        persiststate: true, //persist state of opened contents within browser session?
        toggleclass: ["", "selected"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
        togglehtml: ["", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
        animatespeed: "Fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
        oninit: function(headers, expandedindices) { //custom code to run when headers have initalized
            //do nothing
        },
        onopenclose: function(header, index, state, isuseractivated) { //custom code to run whenever a header is opened or closed
            //do nothing
        }
    })


</script>

<style  type="text/css">

.applemenu {
/*margin:   0px 0;*/
padding: 0;
width: 152px; /*width of menu*/
border: 0px solid #9A9A9A;

}

.applemenu div.silverheader {
/*background:url(../samplenewimg.png) repeat-x;*/

font: normal 12px  Verdana, Geneva, sans-serif; /* Tahoma, "Lucida Grande", "Trebuchet MS", Helvetica, sans-serif;*/
font-weight: bold;
color: #1260a2;
background-image:url(../Images/task2.png);
background-repeat: no-repeat;
position:relative; /*To help in the anchoring of the ".statusicon" icon image*/
width:152px; /* auto;*/
/*padding-top: 13px;
padding-left:12px;*/

height:36px;
text-decoration: none;

}

.applemenu div.silverheader visited, .applemenu div.silverheader active{

}


.applemenu div.selected , .applemenu div.silverheader hover{
/*background-image: url('../silvergradientover.gif');  titlebar.png*/
/*background-image: url(titlebar-active.png);*/

background-image:url(../Images/task3.png);
	background-repeat: no-repeat;
	
/*background-color:Green;*/

width:152px; /* auto;*/
/*padding-top:13px;*/

height:36px;
/*padding-left:12px;*/
text-decoration: none;
font: normal 12px  Verdana, Geneva, sans-serif; /* Tahoma, "Lucida Grande", "Trebuchet MS", Helvetica, sans-serif;*/
font-weight: bold;
color:  white;

}

.applemenu div.submenu{ /*DIV that contains each sub menu*/
/*background: white;*/
/*padding:  0px;*/
height:  auto ; /* 250px; /*Height that applies to all sub menu DIVs. A good idea when headers are toggled via "mouseover" instead of "click"*/
}


    

</style>--%>

    
<div id="leftDiv"  runat="server">
 <div class="arrowlistmenu">
    <div class="menuheader"><div class="dropmenutxt"><asp:Label ID="lbcorp" 
            runat="server" Text="Corporate" meta:resourcekey="lbcorpResource1"></asp:Label></div></div>
      <div class="categoryitems">
    <%--<div id="midIP" runat="server" style="cursor:pointer;" onclick="showIP();"></div>--%>
    <div id="hideIPdiv" style="display: block;">
        <ul class="boxe">
         <asp:Repeater ID="rptIP" runat="server">
            <ItemTemplate>
                <asp:HyperLink ID="hlk" Font-Underline="False" 
                    NavigateUrl='<%# Eval("MenuURL") %>' runat="server" 
                    meta:resourcekey="hlkResource1"> 
                    <li class="boxmenu_2"><%#Eval("MenuName")%>
                </li></asp:HyperLink>
            </ItemTemplate>
        </asp:Repeater>
        </ul>
    
        <ul class="bottom">
        <li></li>
        </ul>
    </div>
 </div>
 </div>
</div>    
