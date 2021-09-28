<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="PMS_Home" %>
<%@ Register Src="~/PMS/controls/Header.ascx" TagName="Header" TagPrefix="Header" %>
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
    <link href="css/dashboard.css" rel="stylesheet" />

    <script src="../Scripts/jquery-1.10.2.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        $(function() {
       
            var folderID = $('input[id$="hdnFolderID"]').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "WebService.asmx/GetAllCategoriesandFolders",
                data: JSON.stringify({ FolderID: folderID }),
                dataType: "json",
                async: false,
                success: function(data) {

                    if (data.d.length > 0) {
                        var list = data.d;
                        if (list[0].length > 0) {
                            var listCategories = list[0];
                            var listFolders = list[1];
                            var lstPanelCSS = ["panel panel-success", "panel panel-info", "panel panel-warning", "panel panel-danger"];
                            var cssCount = 0;
                            $.each(listCategories, function(i, obj) {

                                var divColumn = $(document.createElement('div'));
                                $(divColumn).addClass("col-md-6");
                                var divParent = $(document.createElement('div'));
                                $(divParent).addClass(lstPanelCSS[cssCount]);
                                if (cssCount == 3) {
                                    cssCount = 0;
                                }
                                cssCount++;
                                $(divParent).append('<div class="panel-heading text-center"><h3 class="panel-title"> ' + obj.Name + ' </h3></div>');
                                var DivChild = $(document.createElement('div'));
                                $(DivChild).addClass("panel-body");
                                var objID = obj.ID;

                                $.each(listFolders, function(i, obj1) {
                                    if (objID == obj1.ParentID) {
                                        var dl = $(document.createElement('dl'));
                                        if (obj1.Type == 'Folder') {
                                            $(dl).append($('<dt>').append($('<span class="glyphicon glyphicon-folder-close" aria-hidden="true">')).append("&nbsp;" + obj1.Name));
                                            $(dl).append($('<dd>').append(obj1.Description));

                                            $(divColumn).append(
                                            $(divParent).append(
                                        $(DivChild).append(
                                        $('<div class="toolItemHighlight">').append(
                                        $('<a class="toolItemAnchorHover">').attr('href', 'Home.aspx?FldID=' + obj1.ID + '').append($(dl))))));
                                        }
                                        else {
                                            $(dl).append($('<dt>').append($('<span class="glyphicon glyphicon-file" aria-hidden="true">')).append("&nbsp;" + obj1.Name));
                                            $(dl).append($('<dd>').append(obj1.Description));

                                            $(divColumn).append(
                                            $(divParent).append(
                                        $(DivChild).append(
                                        $('<div class="toolItemHighlight">').append(
                                        $('<a class="toolItemAnchorHover">').attr('href', 'Render.aspx?ProcID=' + obj1.ID + '&Title=' + obj1.Name).append($(dl))))));
                                        }
                                    }

                                });
                                $('#divCategories').append(divColumn);
                            });
                        }
                    }
                },
                error: function(result) {
                    alert("Error in Json Method");
                }
            });
            //return false;
        });
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <Header:Header ID="ucHeader" runat="server" />
    <div class="container-fluid">
        <div class="page-header">
            <h3>
                 </h3> 
        </div>
        <div id="divCategories" class="row">
        </div>
        <%-- <div class="panel panel-default">
            <div id="divCategories" class="panel-heading">
            </div>
            <div id="divFolders" class="panel-body">
                Panel content
            </div>
        </div>--%>
    </div>
      <asp:HiddenField ID="hdnLoginID" runat="server" />
    <asp:HiddenField ID="hdnFolderID" runat="server" />
    </form>
</body>
</html>
