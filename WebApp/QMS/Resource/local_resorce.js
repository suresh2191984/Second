




$(function() {

    dataTablePath = "Resource/datatable.lang." + SLanguageCode + ".json";
 //   dataTablePath = 'Resource/datatable.lang.Spanish.json';
  //  var langFileURl = "Resource/lang." + SLanguageCode + ".json";
    var langFileURl = "Resource/DisplayText_" + SLanguageCode + ".json";
    $.ajax({
        url: langFileURl,
        type: "GET",
        dataType: "json",
        contentType: "application/json; charset=iso-8859-1",
        async: false,
        success: function(uri) {
         
            langData = uri[0];
        },
        beforeSend: function(jqXHR) {
            jqXHR.overrideMimeType('application/json;charset=iso-8859-1');
        }
    });


    $.each($('*[localize]'), function(id, val) {
        var attrVal = $(val).attr('localize');
        var value = langData[attrVal];
        var tagName = val.tagName;
        setVAL(tagName, val, attrVal, value);

    });
});

function setVAL(tagName, ctrl, key, value) { 

switch(tagName) {
    case 'INPUT':
        setInputVal(ctrl,key);
        break;
//    case 'P':
//        setTextVal(ctrl,key);
//        break;
    default:
        $(ctrl).html(value);
        
}

}

function setTextVal(ctrl,key)
{
var value=langData[key];
$(ctrl).html(value);
}


function setInputVal(ctrl,key)
{
var type=$(ctrl).attr('type');
var value=langData[key];
switch(type) {
    case 'button':
       $(ctrl).attr('value',value);
        break;
    case 'text':
        $(ctrl).val('text',value);
        break;
    default:
        $(ctrl).attr('value', value);
        }
    }





