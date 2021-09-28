<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language="javascript" type="text/javascript">

    function ClientSidePrint(idDiv) {

        var sOption = "toolbar=no,location=no,directories=no,menubar=no,scrollbars=0,width=120,height=120";
        // Get the HTML content of the div
        var sDivText = window.document.getElementById('ven').innerHTML;
        // Print the window           
        var objWindow = window.open("", "", sOption);
        // Write the div element to the window objWindow.document.write(sDivText); objWindow.document.close(); // Print the window                  
        print();
        // Close the window
        objWindow.close();
    }
    
    function print() {
//        if (document.all) {
//        //Set WebBrowser1 = CreateObject("InternetExplorer.Application")
//            WebBrowser1.ExecWB(6, 6) //use 6, 1 to prompt the print dialog or 6, 6 to omit it;
//            WebBrowser1.outerHTML = "";
//        }
//        else {
//            window.print();
        //        }

        if (navigator.appName == "Microsoft Internet Explorer") {
            var PrintCommand = '<object ID="PrintCommandObject" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>';
            document.body.insertAdjacentHTML('beforeEnd', PrintCommand);
            PrintCommandObject.ExecWB(6, 1); PrintCommandObject.outerHTML = "";
        }
        else {
            window.print();
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <object ID="WebBrowser1" WIDTH="0" HEIGHT="0"
CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
</object>
    <div>
       <div id="ven" runat="server" >
         print
       </div>    
       <asp:Button ID="btn" runat="server" Text="Click" OnClientClick="ClientSidePrint()" />
       
    </div>
    </form>
</body>
</html>
