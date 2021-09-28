<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">
        function lWindow() {
            var w, h;
            if (window.screen) {
                var percent = 100;
                w = window.screen.availWidth * percent / 100;
                h = window.screen.availHeight * percent / 100;
            }
            window.open('Home.aspx', '', 'fullscreen=yes, scrollbars=yes');
        }
</script>
    <link href="PlatForm/StyleSheets/Index.css" rel="stylesheet" type="text/css" />
</head>
<body onload="lWindow();">
  <form id="form1" runat="server">
    <div id="header">
  <div  style="height:15px;" >
  <ul id="rlogocontent">
			<li><img src="Platform/images/log.png" alt="" width="220" height="40" title="Attune Tech" /></li>
	</ul></div>
<img src="Platform/images/txt.PNG" alt="" width="419" height="44" /></div>

	<div id="titletxt"></div>

	<div id="hidden">
		
	</div>

	
		<div class="contentbox">
			<h3><asp:Label ID="lblOur" runat="server" Text="Server" meta:resourcekey="lblOurResources1"></asp:Label> &nbsp;
			<asp:Label ID="lblCompany" runat="server" Text="Company" meta:resourcekey="lblCompanyResources1" CssClass="red"></asp:Label>
		</h3>
		  <p><asp:Label ID="lblOurInfo" runat="server" Text=" We enable our customers to 
identify their most pressing strategic business challenges and innovatively apply IT to solve them..." meta:resourcekey="lblOurInfoResources1"></asp:Label>
		 </p>
<p class="box1"><a href="http://www.attunelive.com" title="Attune Tech "><asp:Label ID="lblcmore" runat="server" Text="More" meta:resourcekey="lblcmoreResources1"></asp:Label></a></p>
		</div>
	  <div class="contentbox">
			<h3><asp:Label ID="lblValue" runat="server" Text="Value" meta:resourcekey="lblValueResources1"></asp:Label> &nbsp; 
			<asp:Label ID="lblProposition" runat="server" Text="Proposition" meta:resourcekey="lblPropositionResources1" CssClass="red"></asp:Label>
			</h3>
		<p><asp:Label ID="lblValueifo" runat="server" Text="Our Solutions are aligned with the business goals of our Customers, thereby, ensuring enhanced business             benefits..." meta:resourcekey="lblValueifoResources1"></asp:Label>
		</p>
            
        <p class="box2" ><a href="http://www.attunelive.com" title="Attune Tech"><asp:Label ID="lblpmore" runat="server" Text="More" meta:resourcekey="lblpmoreResources1"></asp:Label></a></p>
</div>

        <div class="contentbox">
			<h3><asp:Label ID="lblEngagement" runat="server" Text="Engagement" meta:resourcekey="lblEngagementResources1"></asp:Label> &nbsp; 
			<asp:Label ID="lblModel" runat="server" Text="Model" meta:resourcekey="lblModelResources1" CssClass="red"></asp:Label></h3>
			<p><asp:Label ID="lblEngagementinfo" runat="server" Text="Our Consultative Engagement Model enables us to deliver customized solutions enabling better integration 
			of players across the ecosystem..." meta:resourcekey="lblEngagementinfoResources1" CssClass="red"></asp:Label>
			</p>
		  <p class="box3"><a href="http://www.attunelive.com" title="Attune Tech"><asp:Label ID="lblVMore" runat="server" Text="More" meta:resourcekey="lblVMoreResources1"></asp:Label></a></p>
		</div>
        <div class="contentbox box4">
        <div class="cssnav" onclick="javascript:lWindow()">
                            <a href=""><img src="Platform/images/loginbtn.png"/></a>
                    </div>
        </div>

	
<div id="footer">

		  <p class="right ">&copy;<asp:Label ID="lblAttune" runat="server" Text="Attune Technologies." meta:resourcekey="lblAttuneResources1"></asp:Label> </p>
</div>
 

    </form>
</body>

</html>

