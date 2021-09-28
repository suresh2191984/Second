/*!
* jQuery namespaced 'Starter' plugin boilerplate
* Author: @dougneiner
* Further changes: @addyosmani
* Licensed under the MIT license
*/
var files = [];
var IDs = [];
; (function($) {
    if (!$.Attune) {
        $.Attune = {};
    };

    $.Attune.FileUpload = function(el, myFunctionParam, options) {

        var base = this;
        var isFileType = myFunctionParam['fileCheck'];
        if (isFileType) {
            $(el).click(function() {
                $filtype = $('#' + options['fileddl']);
                if ($filtype.val() == 0) {

                    alert(langData.alert_filetype);
                    return false;
                }

            });
        }

        $(el).change(function() {
            var hasfile;
            var filetype;
            var FileName;
            var FilePath;
            var files1;
            var filetype = "";
            if (isFileType) {
                filetype = $('#' + options['fileddl'] + ' option:selected').text();
            }
            hasfile = "Y";
            FileName = $(el).get(0);
            files1 = FileName.files;
            FileName = $(el).val().replace(/C:\\fakepath\\/i, '')
            var types = $(".MultiFile-remove");
            var len = 0;

            for (var i = 0; i < files1.length; i++) {

                files.push([files1[i], filetype]);
                var d = '<div id="' + files1[i].name + '" class="MultiFile-label">\
                     <a class="MultiFile-remove"  filetype="' + filetype + '" href="#txtfileupload_wrap" style="color:red;font-size:large;font-weight:900">x</a>\
                     <span class="MultiFile-title" >' + files1[i].name + '  -  ' + filetype + '</span>\
                     </div>';

                $("#txtfileupload_wrap_list").append(d);

                $('.MultiFile-remove').click(function() {
                    var div = $(this).parent('div');
                    var id = $(div).attr('id')

                    var found_names = $.grep(files, function(v) {
                        return v[0].name != id;
                    });
                    files = found_names;
                    $(div).remove();
                    if (files.length == 0) {
                        $(el).val('');
                    }
                });

            }




        });


        // Access to jQuery and DOM versions of element
        base.$el = $(el);
        base.el = el;

        // Add a reverse reference to the DOM object
        base.$el.data("myNamespace.myPluginName", base);

        base.init = function() {
            base.myFunctionParam = myFunctionParam;

            base.options = $.extend({},
            $.Attune.FileUpload.defaultOptions, options);

            // Put your initialization code here
        };

        // Sample Function, Uncomment to use
        // base.functionName = function( paramaters ){
        // 
        // };
        // Run initializer
        base.init();
    };

    $.Attune.FileUpload.defaultOptions = {
        myDefaultValue: ""
    };

    $.fn.Attune_FileUpload = function
        (myFunctionParam, options) {
        return this.each(function() {
            (new $.Attune.FileUpload(this,
            myFunctionParam, options));
        });
    };
    $.fn.Attune_GetFiles = function
        () {
        return files;
    };

    $.fn.Attune_RemoveFiles = function
        () {
        files = [];
        $(this).val('');
        return files;
    };

})(jQuery);