function EndRequestHandler(e, t) { var a; a = GetServerDate(), $(".dateTimePicker").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: jQueryDateFormat, timeFormat: JQueryTimeFormat, hour: a.getHours(), minute: a.getMinutes(), second: a.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".dateTimePickerFutureDate").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: jQueryDateFormat, timeFormat: JQueryTimeFormat, hour: a.getHours(), minDate: GetServerDate(), minute: a.getMinutes(), second: a.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerlasttwodaystime").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: jQueryDateFormat, timeFormat: JQueryTimeFormat, hour: a.getHours(), maxDate: GetServerDate(), minDate: -1, minute: a.getMinutes(), second: a.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePicker").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: jQueryDateFormat, yearRange: "1866:" + ToYear, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerFuture").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, minDate: GetServerDate(), dateFormat: jQueryDateFormat, yearRange: "2015:2050", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }); var n = $("#hdnMonthFormat").val(); n = n.replace("yyyy", "yy").replace("MMM", "M").replace("MM", "mm"), $(".monthYearPicker").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: n, beforeShow: function(e, t) { $("#ui-datepicker-div").addClass("hide-calendar") }, onChangeMonthYear: function(e, t, a) { 10 > t && (t = "0" + t); var n = new Date(e, t, 0, 0, 0, 0, 0); n = ToExternalMonth(n), n = n.replace("yyyy", "yy").replace("MMM", "M").replace("MM", "mm"), $("#" + a.id).val(n) } }), $(".timePicker").timepicker({ showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, hour: a.getHours(), minute: a.getMinutes(), second: a.getSeconds(), timeFormat: JQueryTimeFormat, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerFuture").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: jQueryDateFormat, minDate: GetServerDate(), yearRange: "2015:2050", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerPres").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", maxDate: 0, buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: jQueryDateFormat, yearRange: "1920:2100", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".date-picker-year").datepicker({ changeYear: !0, showButtonPanel: !0, showOn: "both", dateFormat: "yy", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, yearRange: "2000:2025", onClose: function(e, t) { var a = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); $(this).datepicker("setDate", new Date(a, 1)) }, onChangeMonthYear: function(e, t, a) { $("#" + a.id).val(e) } }), $(".date-picker-year").focus(function() { $(".ui-datepicker-calendar").hide(), $(".ui-datepicker-month").hide() }); var r; r = $("[id$=_hdnServerDateTime]").length > 0 ? new Date($("[id$=_hdnServerDateTime]")[0].value) : GetServerDate(); var o = new Date(r.getFullYear(), r.getMonth(), r.getDate() - 2), i = new Date(r.getFullYear(), r.getMonth(), r.getDate()); $(".dateSepDate").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", minDate: o, maxDate: i, buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: jQueryDateFormat, yearRange: "2000:2025", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerPresTime").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: jQueryDateFormat, timeFormat: JQueryTimeFormat, hour: a.getHours(), minute: a.getMinutes(), second: a.getSeconds(), maxDate: 0, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }) } function SetDatePickterValue() { var e, t = $("#hdnDateFormat").val(); t = t.replace("yyyy", "yy").replace("MMM", "M").replace("MM", "mm"), t = t.replace("ddd", "D"), e = GetServerDate(); var a = $("#hdnTimeFormat").val(); $(".dateTimePicker").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".dateTimePickerFutureDate").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), minDate: GetServerDate(), minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerlasttwodaystime").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), maxDate: GetServerDate(), minDate: -1, minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePicker").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "1866:" + ToYear, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }); var n = $("#hdnMonthFormat").val(); n = n.replace("yyyy", "yy").replace("MMM", "M").replace("MM", "mm"), $(".monthYearPicker").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: n, beforeShow: function(e, t) { $("#ui-datepicker-div").addClass("hide-calendar") }, onChangeMonthYear: function(e, t, a) { 10 > t && (t = "0" + t); var n = new Date(e, t, 0, 0, 0, 0, 0); n = ToExternalMonth(n), n = n.replace("yyyy", "yy").replace("MMM", "M").replace("MM", "mm"), $("#" + a.id).val(n) } }), $(".timePicker").timepicker({ showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, hour: e.getHours(), minute: e.getMinutes(), second: e.getSeconds(), timeFormat: a, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerFuture").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "2015:2050", minDate: GetServerDate(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerPres").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", maxDate: 0, buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "1920:2100", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".date-picker-year").datepicker({ changeYear: !0, showButtonPanel: !0, showOn: "both", dateFormat: "yy", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, yearRange: "2000:2025", onClose: function(e, t) { var a = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); $(this).datepicker("setDate", new Date(a, 1)) }, onChangeMonthYear: function(e, t, a) { $("#" + a.id).val(e) } }), $(".date-picker-year").focus(function() { $(".ui-datepicker-calendar").hide(), $(".ui-datepicker-month").hide() }); var r; r = $("[id$=_hdnServerDateTime]").length > 0 ? new Date($("[id$=_hdnServerDateTime]")[0].value) : GetServerDate(); var o = new Date(r.getFullYear(), r.getMonth(), r.getDate() - 2), i = new Date(r.getFullYear(), r.getMonth(), r.getDate()); $(".dateSepDate").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", minDate: o, maxDate: i, buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "2000:2025", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerPresTime").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), minute: e.getMinutes(), second: e.getSeconds(), maxDate: 0, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }) } function Check_FOR_AMS_VIS_ASD(e, t, a, n, r) { var o = ""; $("[id$=_hdnApplicationStartDate]").length > 0 && (o = $("[id$=_hdnApplicationStartDate]")[0].value); var i = ""; $("[id$=_hdnPatientAdmissionDate]").length > 0 && (i = $("[id$=_hdnPatientAdmissionDate]")[0].value); var d = ""; $("[id$=_hdnPatientVisitDate]").length > 0 && (d = $("[id$=_hdnPatientVisitDate]")[0].value); var c = ""; $("[id$=hdnApplicationSystemDate]").length > 0 && (c = $("[id$=_hdnApplicationSystemDate]")[0].value); var h = ""; if (h = "ApplicationStartDate" == a ? o : "AdmissionDate" == a ? i : "VisitDate" == a ? d : "OP" == n ? d : "IP" == n ? i : o, "" != h && "" != c) { var m = h.split("/"), s = m[1] + "/" + m[0] + "/" + m[2], l = t.split("/"), u = l[1] + "/" + l[0] + "/" + l[2], g = new Date(s), y = new Date(u); difference_in_milliseconds = y - g; var S = c.split("/"), b = S[1] + "/" + S[0] + "/" + S[2], v = new Date(b); return difference_Future_milliseconds = v - y, difference_in_milliseconds < 0 ? ($("#" + e).val(c), $("#" + e).focus(), alert(r + h), !1) : !0 } return !0 } var curDate = new Date, CurYear = curDate.getFullYear(), ToYear = CurYear + 10; $(document).ready(function() { Sys.Application._endRequestHandler = EndRequestHandler }), $(function() { var e, t = $("#hdnDateFormat").val(); t = t.indexOf("yyyy") > -1 ? t.replace("yyyy", "yy") : t.replace("yy", "y"), t = t.replace("MMM", "M").replace("MM", "mm"), t = t.replace("ddd", "D"); var a = $("#hdnTimeFormat").val(); e = GetServerDate(), $(".dateTimePicker").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".dateTimePickerFutureDate").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), minDate: GetServerDate(), minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerlasttwodaystime").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), maxDate: GetServerDate(), minDate: -1, minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".dateTimePickerPastDate").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), maxDate: GetServerDate(), minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerCurrentDateOnly").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), maxDate: GetServerDate(), minDate: 0 , minute: e.getMinutes(), second: e.getSeconds(), beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePicker").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "1866:" + ToYear, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerFuture").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, minDate: GetServerDate(), dateFormat: t, yearRange: "2015:2050", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerPast").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, maxDate: GetServerDate(), dateFormat: t, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }); var n = $("#hdnMonthFormat").val(); n = n.replace("yyyy", "yy").replace("MMM", "M").replace("MM", "mm"), $(".monthYearPicker").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: n, beforeShow: function(e, t) { $("#ui-datepicker-div").addClass("hide-calendar") }, onChangeMonthYear: function(e, t, a) { 10 > t && (t = "0" + t); var n = new Date(e, t, 0, 0, 0, 0, 0); n = ToExternalMonth(n), n = n.replace("yyyy", "yy").replace("MMM", "M").replace("MM", "mm"), $("#" + a.id).val(n) } }), $(".timePicker").timepicker({ showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, hour: e.getHours(), minute: e.getMinutes(), second: e.getSeconds(), timeFormat: a, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerFuture").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, minDate: GetServerDate(), yearRange: "2015:2050", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerfunture").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "2015:2050", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerPres").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", maxDate: 0, buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "1920:2100", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".date-picker-year").datepicker({ changeYear: !0, showButtonPanel: !0, showOn: "both", dateFormat: "yy", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, yearRange: "2000:2025", onClose: function(e, t) { var a = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); $(this).datepicker("setDate", new Date(a, 1)) }, onChangeMonthYear: function(e, t, a) { $("#" + a.id).val(e) } }), $(".date-picker-year").focus(function() { $(".ui-datepicker-calendar").hide(), $(".ui-datepicker-month").hide() }); var r; r = $("[id$=_hdnServerDateTime]").length > 0 ? new Date($("[id$=_hdnServerDateTime]")[0].value) : GetServerDate(); var o = new Date(r.getFullYear(), r.getMonth(), r.getDate() - 2), i = new Date(r.getFullYear(), r.getMonth(), r.getDate()); $(".dateSepDate").datepicker({ changeMonth: !0, changeYear: !0, showOn: "both", minDate: o, maxDate: i, buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0, dateFormat: t, yearRange: "2000:2025", beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }), $(".datePickerPresTime").datetimepicker({ changeMonth: !0, changeYear: !0, showOn: "both", buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, dateFormat: t, timeFormat: a, hour: e.getHours(), minute: e.getMinutes(), second: e.getSeconds(), maxDate: 0, beforeShow: function(e, t) { $("#ui-datepicker-div").removeClass("hide-calendar") } }) });