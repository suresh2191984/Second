var ServerDate = new Date();
var iscurrdate = false;
setInterval(function() { iscurrdate = false; }, 60000);
function GetServerDate() {

    if (iscurrdate)
    { return new Date(ServerDate); }
    else {

        $.ajax({
            type: "GET",
            url: "../PlatformWebServices/PlatFormServices.asmx/GetServerDate",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                ServerDate = new Date(data.d);
                // ServerDate = new Date(moment.utc(parseInt(data.d.substr(6))).format()).toUTCString();
                iscurrdate = true;
            },
            failure: function(msg) {
                //alert('error');
                return false;
            }
        });

        return ServerDate;
    }
}

function GetTimeZone() {
    var timeZone;
    $.ajax({
        type: "GET",
        url: "../PlatformWebServices/PlatFormServices.asmx/GetTimeZone",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            timeZone = data.d;
            // ServerDate = new Date(moment.utc(parseInt(data.d.substr(6))).format()).toUTCString();

        },
        failure: function(msg) {
            //alert('error');
            return false;
        }
    });

    return timeZone;
}

function SortedList() { this.innerList = new Array, this.Set = function(t, i) { this.innerList[t] = i }, this.Load = function(t) { for (var i = t.split("^"), n = 0; n < i.length; n++) { var s = i[n].split("="); this.Set(s[0], s[1]) } }, this.Exist = function(t) { return "undefined" != typeof this.innerList[t] }, this.Get = function(t) { var i = this.innerList[t]; return "undefined" == typeof i ? null : i } } var SListForApplicationMessages = new SortedList, SListForAppMsg = new SortedList, SListForAppDisplay = new SortedList;


var KEYCODE_F5 = 116;
var KEYCODE_ESC = 27;
var KEYCODE_BACKSPACE = 8;

$(document).keydown(SuppressKeyStrokes);

function SuppressKeyStrokes(e) {
    if ((e.keyCode == KEYCODE_BACKSPACE && e.target.type != "text" && e.target.type != "textarea" && e.target.type != "password" && e.target.tagName != "DIV") || (e.keyCode == KEYCODE_BACKSPACE && e.target.type == "textarea" && e.target.readOnly == true)) {

	// cancel backspace navigation 
	e.preventDefault(); 
	e.stopImmediatePropagation(); 
	return false; 
	} 

	if (e.keyCode == KEYCODE_F5) {
		e.preventDefault(); 
		e.stopImmediatePropagation(); 
		return false; 
	} 

	if (e.keyCode == KEYCODE_ESC) {
		e.preventDefault(); 
		e.stopImmediatePropagation(); 
		return false; 
	} 
};