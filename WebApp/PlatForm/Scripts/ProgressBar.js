
$(function() {

    var docHeight = $(document).height();
    var docWidth = $(document).width();

    var progLeft = ($(window).width() - 50) / 2;
    var progTop = ($(window).height() - 50) / 2;

    var InnerDiv = $("<div id='innerDiv' style='position: absolute;' >").append("<table style='border-color:Gray; background-color: White;' border=2 cellpadding=1><tr><td><b>Please wait... </b><img src='../PlatForm/Images/ProgressBar.gif'></td></tr></table>");
    var OuterDiv = $("<div id='OuterDiv'></div>");
    $("body").append("<div id='overlay'>").append(InnerDiv).append(OuterDiv);

    $("#OuterDiv")
      .height(docHeight)
      .css({
          'opacity': 0.4,
          'position': 'absolute',
          'top': 0,
          'left': 0,
          'background-color': 'black',
          'width': '100%',
          'z-index': 5000
      });
    $("#innerDiv")
      .height(50)
      .css({
          'position': 'fixed',
          'top': progTop,
          'left': progLeft,
          'width': '50px',
          'z-index': 5001
      });
    $("#overlay").hide();
    $("#OuterDiv").hide();
    $("#innerDiv").hide();


    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_beginRequest(BeginRequestHandler);
    prm.add_endRequest(EndRequestHandler);
    
});

function BeginRequestHandler(sender, args) {
    //Shows the modal popup - the update progress
    fnShowProgress();
}

function EndRequestHandler(sender, args) {
    //Hide the modal popup - the update progress
    fnHideProgress();
}


function fnShowProgress() {
    $("#overlay").show();
    $("#OuterDiv").show();
    $("#innerDiv").show();
}
function fnHideProgress() {

    $("#overlay").hide();
    $("#OuterDiv").hide();
    $("#innerDiv").hide();
}