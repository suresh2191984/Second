<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientLogin.aspx.cs" Inherits="PatientLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MyHealth Clinic</title>
    <link href="StyleSheets/mh-css.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/mh-js.js" type="text/javascript"></script>
<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
<script src="Scripts/SpryMenuBar.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="Scripts/scripts.js"></script>
     <script type="text/javascript">
    function validateUsers() {
    if (document.getElementById('txtUsername').value == '') {
        alert('Provide User name');
        document.getElementById('txtUsername').focus();
        return false;
    }
    if (document.getElementById('txtPassword').value == '') {
        alert('Provide Password');
        document.getElementById('txtPassword').focus();
        return false;
    }
}
</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <form id="form1" runat="server">
    <div>
<table width="903" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2">
        <%--<asp:Image ID="equicom" runat="server" width="900" height="24" border="0"/>--%>
    <p>
    <img src="Images/equicom-group-btn.jpg" alt="equicomgroup" width="900" height="24" border="0" usemap="#Map"/><br>
        <img src="Images/header.jpg" alt="header" width="900" height="140"></p>    </td>
  </tr>
 
  <tr>
    <td colspan="2" valign="top"><table width="100%" height="40" border="0" align="left" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td height="30" align="center"  valign="top">
          <ul id="MenuBar1" class="MenuBarHorizontal">
              <li><a href="http://www.myhealth.ph/index.htm">Home</a></li>
            <li><a href="http://www.myhealth.ph/about.htm">About us</a></li>
            <li><a href="http://www.myhealth.ph/services.htm" >Services</a></li>
            <li><a class="MenuBarItemSubmenu" href="http://portal.myhealth.ph/mh-home.asp#">Medical Staff</a>
                  <ul>
                    <li><a href="http://www.myhealth.ph/festival.htm">Festival Supermall</a> </li>
                    <li><a href="http://www.myhealth.ph/shangri-la.htm">Shangri-La</a></li>
                    <li><a href="http://www.myhealth.ph/sm-north.htm">SM North</a></li>
                    <li><a href="http://www.myhealth.ph/cebu-it-park.htm">Cebu I.T. Park</a></li>
                    <li><a href="http://www.myhealth.ph/robinsons-cebu.htm">Robinsons Cybergate Mall Cebu</a></li>
                  </ul>
            </li>
            <li><a href="http://www.myhealth.ph/appointments.htm" class="">Appointments</a></li>
            <li><a href="http://www.myhealth.ph/news.htm" class="MenuBarItemSubmenu">News &amp; Promos</a>
                  <ul>
                    <li><a href="http://www.myhealth.ph/news.htm">News</a></li>
                    <li><a href="http://www.myhealth.ph/promos.htm">Promos</a></li>
                  </ul>
            </li>
            <li><a href="http://portal.myhealth.ph/mh-home.asp#" class="MenuBarItemSubmenu">Contact us</a>
                  <ul>
                    <li><a href="http://www.myhealth.ph/c-festival.htm">Festival Supermall</a></li>
                    <li><a href="http://www.myhealth.ph/c-shangri-la.htm">Shangri-La</a></li>
                    <li><a href="http://www.myhealth.ph/c-sm-north.htm">SM North</a></li>
                    <li><a href="http://www.myhealth.ph/c-cebu-it-park.htm">Cebu I.T. Park</a></li>
                    <li><a href="http://www.myhealth.ph/c-robinsons-cebu.htm">Robinsons Cybergate Mall Cebu</a></li>
                  </ul>
            </li>
          </ul></td>
        </tr>
</tbody>
      <tbody>
      </tbody>
      <tbody>
      </tbody>
      <tbody>
      </tbody>
      <tbody>
      </tbody>
      <tbody>
      </tbody>
      <tbody>
      </tbody>
      <tbody>
      </tbody>
    </table></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>


<table width="901" height="300" border="0" align="center" cellpadding="0" cellspacing="0">
<tr valign=top>
<td>
	<p class="headline"><strong>Online Results</strong></p>
</td>
</tr>
<tr valign=top>
<td>
	<table border="0">
	<tr>
	<td>
		<%--<form name=frmPatient method=post action="http://portal.myhealth.ph/patientlogin2.asp">--%>
		<table class="box" width="80%" border=0 >
		
		<tr>
			<td width=5px nowrap></td><td>Login ID:</td><td><asp:TextBox ID=txtUsername runat="server" MaxLength="20" Width="210px"></asp:TextBox></td>
		</tr>
		<tr height=5px><td></td></tr>
		<tr>
			<td width=5px nowrap></td><td>Password:</td><td><asp:TextBox ID=txtPassword runat="server" MaxLength="20" 
                                                Width="210px" TextMode="Password"></asp:TextBox>&nbsp;&nbsp;<asp:Button 
                                                ID="btnSubmit" runat="server" Text="Log In" OnClientClick="return validateUsers();" onclick="btnSubmit_Click" /></td>
		</tr>
		<tr>
			<td colspan="2"></td><td style="color:#888888;">*For first time users, this is the Customer ID and Password  found in the Official Receipt.</td>
		</tr>
		<tr height=10px><td></td></tr>
		</table>
		
		<%--<div class="bodytext" style="color:#888888;"><center>Online Results provided by:</center></div>
		<center><a href="https://www.healthonlineasia.com"><img src="Images/healthonline.jpg" border=0></a></center>--%>
	</td>
	</tr>
	</table>
</td>
</tr>
</table>
<table width="100%" height="74" border="0" cellpadding="0" cellspacing="0" background="Images/bgfooter.jpg">
  <tr>
    <td><table width="900" border="0" align="center" cellpadding="0" cellspacing="0" class="footertbl">
      <tr>
        <td>&copy; 2010 MyHealth Clinic.  All rights reserved</td>
        <td><div align="right"><a href="http://www.myhealth.ph/index.htm">Home</a> |<a href="http://www.myhealth.ph/about.htm"> About Us</a> | <a href="http://www.myhealth.ph/services.htm">Services</a> | <a href="http://www.myhealth.ph/medstaff/festival.htm">Medical Staff</a> |<a href="http://www.myhealth.ph/appointments.htm"> Appointments</a> | <a href="http://www.myhealth.ph/contact/festival.htm">Feedback</a></div></td>
      </tr>
    </table></td>
  </tr>
</table>
<map name="Map"><area shape="rect" coords="702,7,866,20" href="http://www.equicomgroup.com.ph" target="_blank" alt="An Equicom Company">
</map>

    </div>
    </form>
    <script type="text/javascript">
        var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", { imgDown: "/js/SpryAssets/SpryMenuBarDownHover.gif", imgRight: "/js/SpryAssets/SpryMenuBarRightHover.gif" });

</script>
</body>
</html>
