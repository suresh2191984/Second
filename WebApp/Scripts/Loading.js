
function ShowProgress() {
    setTimeout(function() {
        var modal = $('<div />');
        // modal.addClass("modal");
        modal.css({ "position": "fixed", "top": "0px", "left": "0px", "background-color": "black", "z-index": "99", "opacity": "0.8", "filter": "alpha(opacity=80)", "-moz-opacity": "0.8", "min-height": "100%", "width": "100%" });
        $('body').append(modal);
        var loading = $(".loading");
        loading.show();
        var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
        var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
        loading.css({ top: top, left: left });
    }, 200);
}

/***Added For Progress bar***/