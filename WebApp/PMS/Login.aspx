<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="PMS_Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="css/login.css" rel="stylesheet" />

    <script src="../Scripts/jquery-1.10.2.min.js" language="javascript" type="text/javascript"></script>

</head>
<body>
<div class="container">    
        
    <div id="loginbox" class="mainbox col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3"> 
        
        <div class="row">                
            <div class="iconmelon">
            </div>
        </div>
        <div class="row">
            <img id="profile-img" class="profile-img-card" src="images/attune_logo_website.png" />
        </div>
        
        <p id="profile-name" class="profile-name-card"></p>
        <div class="panel panel-primary" >
            <div class="panel-heading">
                <div class="panel-title">Log in</div>
            </div>     

            <div class="panel-body" >

                <form name="form" id="form" class="form-horizontal" enctype="multipart/form-data" method="POST" runat="server">
                   
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <asp:TextBox ID="txtUserName" runat="server" type="text" CssClass="form-control" name="user" value="" placeholder="Username" required/>                                        
                    </div>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" name="password" placeholder="Password" required/>
                    </div>                                                                  

                    <div class="form-group">
                        <div class="col-sm-12 controls">
                            <asp:Button CssClass="btn btn-primary pull-right" runat="server" ID="btnLogin" OnClick="btnLogin_Click" Text="Log in"></asp:Button>
                        </div>
                    </div>

                </form>     

            </div>                     
        </div>  
    </div>
</div>

</body>
</html>
