<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Resource/local_resorce.js" type="text/javascript"></script>
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
    <link href="StyleSheets/Index.css" rel="stylesheet" type="text/css" />
</head>
<body onload="lWindow();">
  <form id="form1" runat="server">
    <div id="header">
  <div  style="height:15px;" >
  <ul id="rlogocontent">
			<li><img src="images/log.png" alt="" width="220" height="40" title="Attune Tech" /></li>
	</ul></div>
<img src="images/txt.PNG" alt="" width="419" height="44" /></div>

	<div id="titletxt"></div>

	<div id="hidden">
		
	</div>

	
		<div class="contentbox">
			<h3>Our <span class="red">Company</span></h3>
		  <p>We enable our customers to 
identify their most pressing strategic business challenges and innovatively apply IT to solve them...</p>
<p class="box1"><a href="http://www.attunelive.com" title="Attune Tech">More</a></p>
		</div>
	  <div class="contentbox">
			<h3>Value <span class="red">Proposition</span></h3>
		<p>Our Solutions are aligned with the business goals of our Customers, thereby, ensuring enhanced business             benefits...</p>
            
        <p class="box2" ><a href="http://www.attunelive.com" title="Attune Tech">More</a></p>
</div>

        <div class="contentbox">
			<h3>Engagement <span class="red">Model</span></h3>
			<p>Our Consultative Engagement Model enables us to deliver customized solutions enabling better integration 
			of players across the ecosystem...</p>
		  <p class="box3"><a href="http://www.attunelive.com" title="Attune Tech">More</a></p>
		</div>
        <div class="contentbox box4">
        <div class="cssnav" onclick="javascript:lWindow()">
                            <a href=""><img src="images/loginbtn.png"/></a>
                    </div>
        </div>

	
<div id="footer">

		  <p class="right ">&copy; Attune Technologies.</p>
</div>
 

    </form>
</body>

</html>

