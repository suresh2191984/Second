
    function navigateURL(PageID, URL, MenuName) {
        //$.ajax({ url: URL, headers: { 'ParentID': ParentID} ,async:false}).done(function() { alert('success'); });
        var $form = $("<form/>").attr("id", "data_form")
                            .attr("action", URL)
                            .attr("method", "post");
        $("body").append($form);
        //Append the values to be send
        AddParameter($form, "PageID", PageID);
        AddParameter($form, "MenuName", MenuName);
        //Send the Form
        $form[0].submit();
    }


    function LeftMenu(RoleID, OrgID) {
       // var RoleID = 3059; //'<%= Session["RoleID"] %>';
      //  var OrgID = 98; //'<%=Session["OrgID"] %>';
        var ParentID = -1;
        //    var menu = '<li id=Header class="treeview"><a href="#">\
        //                            <i class="fa value.HeaderIcon">\
        //                            </i><span> value.Header</span>\
        //                            <i class="fa fa-angle-left
        // pull-right"></i>\
        //                            </a><ul class="treeview-menu">\
        //                            <li><a id="Page-1" URL="/WebApp/QMS/MasterTemplate.aspx"><i class="fa fa-connectdevelop">\
        //                            </i>Analytemaster</a></li></ul></li>';

        //  $(sidebar).append(menu);
     
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../QMS.asmx/GetMenuItems",
            data: JSON.stringify({ roleID: RoleID, orgID: OrgID, parentID: ParentID }),
            dataType: "json",
            success: function(data) {



                //                
                //var data_test = JSON.parse(data.d);
                $.each(data.d, function(key, value) {
                    var header1 = value.HeaderText;
                    var header = $(sidebar).find('li#' + value.ParentID);
                    var len = header.length;
                    if (len > 0) {
                        var submenu = $(header).find('.treeview-menu');
                        $(submenu).append('<li><a href=' + "/webapp" + value.MenuURL + '><i class="fa fa-street-view">\
                            </i>' + value.MenuName + '</a></li>');
                    }
                    else {

                        var menu = '<li id="' + value.Header + '" class="treeview"><a href="#">\
                            <i class="fa ' + value.HeaderIcon + '">\
                            </i><span>' + value.Header + '</span>\
                            <i class="fa fa-angle-left pull-right"></i>\
                            </a><ul class="treeview-menu">\
                            <li><a id="Page-' + value.PageID + '" URL="' + value.MenuURL + '"><i class="fa fa-connectdevelop">\
                            </i>' + value.MenuName + '</a></li></ul></li>';

                        $(sidebar).append(menu);
                    

                    }


                });
             //   ActiveMenu();
              //  var values = getUrlVars();
              //  menuClass(values);

            },

            error: function(result) {
                //BootstrapDialog.alert("Error");
            }
        });
    }

   
        function menuClass(values) {
            $.each(values, function(key, val) {

                if (val == 'mu') {
                    var id = values['mu'];

                    $page = $('#Page-' + id);
                    $(sidebar).children('.treeview').removeClass('active');
                    var parent = $page.parents()[2];
                    $(parent).addClass('active');
                    var page = $page;
                    $(page).addClass('active');


                }

            });
        }


function ActiveMenu() {

    $(sidebar).find('.treeview-menu a').click(function() {

        var id = this.id;
        var list = id.split('-');
        var pageid = list[1];
        var url = $(this).attr('url');
        document.location = url + '?mu=' + pageid;

    });
}
