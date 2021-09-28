 <%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductSearch.ascx.cs"
    Inherits="InventoryCommon_Controls_ProductSearch" %>


<script language="javascript" type="text/javascript">
    function ShowAlertMsg(key) {
        var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_ProductSearch_ascx_01') != null ? SListForAppMsg.Get('InventoryCommon_Controls_ProductSearch_ascx_01') : "The given product is not available";
        var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
        if (userMsg != null && errorMsg != null) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        else {
            ValidationWindow('The given product is not available', 'Alert');
            return false;
        }

        return true;
    }
    function selectText(txtID,ddlID) {


        //    document.getElementById('<%= txtCategory.ClientID%>').value = document.getElementById('<%= ddlCategory.ClientID%>').options[document.getElementById('<%= ddlCategory.ClientID%>').selecetedIndex].text;
        document.getElementById(txtID).value = document.getElementById(ddlID).options[document.getElementById(ddlID).selectedIndex].text;
        document.getElementById(txtID).select();
//        document.getElementById("txtOut").value = document.getElementById('<%= ddlCategory.ClientID%>').value;
        //document.getElementById(txtID).style.display = "none";
        $('#' + txtID).removeClass().addClass('hide');
    }
    function doSearch() {
        //    var customarray = new Array();
        //    customarray = document.getElementById('<%= ddlCategory.ClientID%>').innerText.trim().split(' ');
        //    var obj = actb(document.getElementById('txtCategory'), customarray);
    }
    function doSet(txtID,ddlID) {

        var txtVal = document.getElementById(txtID).value;
        var ddlSel = document.getElementById('<%= ddlCategory.ClientID%>');
        var pattern = new RegExp(txtVal, i);
        var Select = SListForAppDisplay.Get('InventoryCommon_Controls_ProductSearch_ascx_01');
        if (Select == null) {
            Select = "--Select category--";
        }
        if (txtVal.trim() != "" && txtVal != Select && ddlSel.innerText.search(pattern) != -1) {

            for (var i = 0; i < ddlSel.options.length; i++) {
                if (ddlSel.options[i].text == txtVal) {
                    ddlSel.options[i].selected = true;
                    break;
                }
            }
            //alert(ddlSel.options[ddlSel.selectedIndex].value);

        } else {
            ddlSel.options[0].selected = true;
            document.getElementById(txtID).value = document.getElementById('<%= ddlCategory.ClientID%>').options[document.getElementById('<%= ddlCategory.ClientID%>').selectedIndex].text;

        }
//        document.getElementById("txtOut").value = document.getElementById('<%= ddlCategory.ClientID%>').value;
        //document.getElementById(txtID).style.display = "none";
        $('#' + txtID).removeClass().addClass('hide');
    }
</script>
<script type="text/javascript">
    function addEvent(obj, event_name, func_name) {
        if (obj.attachEvent) {
            obj.attachEvent("on" + event_name, func_name);
        } else if (obj.addEventListener) {
            obj.addEventListener(event_name, func_name, true);
        } else {
            obj["on" + event_name] = func_name;
        }
    }
    function removeEvent(obj, event_name, func_name) {
        if (obj.detachEvent) {
            obj.detachEvent("on" + event_name, func_name);
        } else if (obj.removeEventListener) {
            obj.removeEventListener(event_name, func_name, true);
        } else {
            obj["on" + event_name] = null;
        }
    }
    function stopEvent(evt) {
        evt || window.event;
        if (evt.stopPropagation) {
            evt.stopPropagation();
            evt.preventDefault();
        } else if (typeof evt.cancelBubble != "undefined") {
            evt.cancelBubble = true;
            evt.returnValue = false;
        }
        return false;
    }
    function getElement(evt) {
        if (window.event) {
            return window.event.srcElement;
        } else {
            return evt.currentTarget;
        }
    }
    function getTargetElement(evt) {
        if (window.event) {
            return window.event.srcElement;
        } else {
            return evt.target;
        }
    }
    function stopSelect(obj) {
        if (typeof obj.onselectstart != 'undefined') {
            addEvent(obj, "selectstart", function() { return false; });
        }
    }
    function getCaretEnd(obj) {
        if (typeof obj.selectionEnd != "undefined") {
            return obj.selectionEnd;
        } else if (document.selection && document.selection.createRange) {
            var M = document.selection.createRange();
            try {
                var Lp = M.duplicate();
                Lp.moveToElementText(obj);
            } catch (e) {
                var Lp = obj.createTextRange();
            }
            Lp.setEndPoint("EndToEnd", M);
            var rb = Lp.text.length;
            if (rb > obj.value.length) {
                return -1;
            }
            return rb;
        }
    }
    function getCaretStart(obj) {
        if (typeof obj.selectionStart != "undefined") {
            return obj.selectionStart;
        } else if (document.selection && document.selection.createRange) {
            var M = document.selection.createRange();
            try {
                var Lp = M.duplicate();
                Lp.moveToElementText(obj);
            } catch (e) {
                var Lp = obj.createTextRange();
            }
            Lp.setEndPoint("EndToStart", M);
            var rb = Lp.text.length;
            if (rb > obj.value.length) {
                return -1;
            }
            return rb;
        }
    }
    function setCaret(obj, l) {
        obj.focus();
        if (obj.setSelectionRange) {
            obj.setSelectionRange(l, l);
        } else if (obj.createTextRange) {
            m = obj.createTextRange();
            m.moveStart('character', l);
            m.collapse();
            m.select();
        }
    }
    function setSelection(obj, s, e) {
        obj.focus();
        if (obj.setSelectionRange) {
            obj.setSelectionRange(s, e);
        } else if (obj.createTextRange) {
            m = obj.createTextRange();
            m.moveStart('character', s);
            m.moveEnd('character', e);
            m.select();
        }
    }
    String.prototype.addslashes = function() {
        return this.replace(/(["\\\.\|\[\]\^\*\+\?\$\(\)])/g, '\\$1');
    }
    String.prototype.trim = function() {
        return this.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
    };
    function curTop(obj) {
        toreturn = 0;
        while (obj) {
            toreturn += obj.offsetTop;
            obj = obj.offsetParent;
        }
        return toreturn;
    }
    function curLeft(obj) {
        toreturn = 0;
        while (obj) {
            toreturn += obj.offsetLeft;
            obj = obj.offsetParent;
        }
        return toreturn;
    }
    function isNumber(a) {
        return typeof a == 'number' && isFinite(a);
    }
    function replaceHTML(obj, text) {
        while (el = obj.childNodes[0]) {
            obj.removeChild(el);
        };
        obj.appendChild(document.createTextNode(text));
    }

    function actb(obj, ca) {
        /* ---- Public Variables ---- */
        this.actb_timeOut = -1; // Autocomplete Timeout in ms (-1: autocomplete never time out)
        this.actb_lim = 4;    // Number of elements autocomplete can show (-1: no limit)
        this.actb_firstText = false; // should the auto complete be limited to the beginning of keyword?
        this.actb_mouse = true; // Enable Mouse Support
        this.actb_delimiter = new Array(';', ',');  // Delimiter for multiple autocomplete. Set it to empty array for single autocomplete
        this.actb_startcheck = 1; // Show widget only after this number of characters is typed in.
        /* ---- Public Variables ---- */

        /* --- Styles --- */
        this.actb_bgColor = '#aabbcc';
        this.actb_fwidth = obj.style.width;
        this.actb_textColor = '#FFFFFF';
        this.actb_hColor = '#000000';
        this.actb_fFamily = 'Verdana';
        this.actb_fSize = '11px';
        this.actb_hStyle = 'text-decoration:underline;font-weight="bold"';
        /* --- Styles --- */

        /* ---- Private Variables ---- */
        var actb_delimwords = new Array();
        var actb_cdelimword = 0;
        var actb_delimchar = new Array();
        var actb_display = false;
        var actb_pos = 0;
        var actb_total = 0;
        var actb_curr = null;
        var actb_rangeu = 0;
        var actb_ranged = 0;
        var actb_bool = new Array();
        var actb_pre = 0;
        var actb_toid;
        var actb_tomake = false;
        var actb_getpre = "";
        var actb_mouse_on_list = 1;
        var actb_kwcount = 0;
        var actb_caretmove = false;
        this.actb_keywords = new Array();
        /* ---- Private Variables---- */

        this.actb_keywords = ca;
        var actb_self = this;

        actb_curr = obj;

        addEvent(actb_curr, "focus", actb_setup);
        function actb_setup() {
            addEvent(document, "keydown", actb_checkkey);
            addEvent(actb_curr, "blur", actb_clear);
            addEvent(document, "keypress", actb_keypress);
        }

        function actb_clear(evt) {
            if (!evt) evt = event;
            removeEvent(document, "keydown", actb_checkkey);
            removeEvent(actb_curr, "blur", actb_clear);
            removeEvent(document, "keypress", actb_keypress);
            actb_removedisp();
        }
        function actb_parse(n) {
            if (actb_self.actb_delimiter.length > 0) {
                var t = actb_delimwords[actb_cdelimword].trim().addslashes();
                var plen = actb_delimwords[actb_cdelimword].trim().length;
            } else {
                var t = actb_curr.value.addslashes();
                var plen = actb_curr.value.length;
            }
            var tobuild = '';
            var i;

            if (actb_self.actb_firstText) {
                var re = new RegExp("^" + t, "i");
            } else {
                var re = new RegExp(t, "i");
            }
            var p = n.search(re);

            for (i = 0; i < p; i++) {
                tobuild += n.substr(i, 1);
            }
            tobuild += "<font style='" + (actb_self.actb_hStyle) + "'>"
            for (i = p; i < plen + p; i++) {
                tobuild += n.substr(i, 1);
            }
            tobuild += "</font>";
            for (i = plen + p; i < n.length; i++) {
                tobuild += n.substr(i, 1);
            }
            return tobuild;
        }
        function actb_generate() {

            if (document.getElementById('tat_table')) { actb_display = false; document.body.removeChild(document.getElementById('tat_table')); }
            if (actb_kwcount == 0) {
                actb_display = false;
                return;
            }
            a = document.createElement('table');
            a.cellSpacing = '1px';
            a.cellPadding = '2px';
            //a.style.position = 'absolute';
            a.addClass('absolutePos');
            a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + "px";
            a.style.left = curLeft(actb_curr) + "px";
            a.style.backgroundColor = actb_self.actb_bgColor;
            a.style.width = actb_self.actb_fwidth;
            a.id = 'tat_table';
            document.body.appendChild(a);
            if (actb_curr.value.length > 2) {
                //document.getElementById('tat_table').style.display = 'block';
                $('#tat_table').removeClass().addClass('show');
            }
            if (actb_curr.value.length < 2) {
                //document.getElementById('tat_table').style.display = 'none';
                $('#tat_table').removeClass().addClass('hide');
                return;
            }


            var i;
            var first = true;
            var j = 1;
            if (actb_self.actb_mouse) {
                a.onmouseout = actb_table_unfocus;
                a.onmouseover = actb_table_focus;
            }
            var counter = 0;
            for (i = 0; i < actb_self.actb_keywords.length; i++) {
                if (actb_bool[i]) {
                    counter++;
                    r = a.insertRow(-1);
                    if (first && !actb_tomake) {
                        r.style.backgroundColor = actb_self.actb_hColor;
                        first = false;
                        actb_pos = counter;
                    } else if (actb_pre == i) {
                        r.style.backgroundColor = actb_self.actb_hColor;
                        first = false;
                        actb_pos = counter;
                    } else {
                        r.style.backgroundColor = actb_self.actb_bgColor;
                        r.style.width = actb_self.actb_fwidth;
                    }
                    r.id = 'tat_tr' + (j);
                    c = r.insertCell(-1);
                    c.style.color = actb_self.actb_textColor;
                    c.style.fontFamily = actb_self.actb_fFamily;
                    c.style.fontSize = actb_self.actb_fSize;
                    c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
                    c.id = 'tat_td' + (j);
                    c.setAttribute('pos', j);
                    if (actb_self.actb_mouse) {
                        //c.style.cursor = 'pointer';
                        c.addClass('pointer');
                        c.onclick = actb_mouseclick;
                        c.onmouseover = actb_table_highlight;
                    }
                    j++;
                }
                if (j - 1 == actb_self.actb_lim && j < actb_total) {
                    r = a.insertRow(-1);
                    r.style.backgroundColor = actb_self.actb_bgColor;
                    r.style.width = actb_self.actb_fwidth;
                    c = r.insertCell(-1);
                    c.style.color = actb_self.actb_textColor;
                    //c.style.fontFamily = 'arial narrow';
                    c.addClass('fontstyle1');
                    c.style.fontSize = actb_self.actb_fSize;
                    //c.align = 'center';
                    c.addClass('a-center');
                    replaceHTML(c, '\\/');
                    if (actb_self.actb_mouse) {
                        //c.style.cursor = 'pointer';
                        c.addClass('pointer');
                        c.onclick = actb_mouse_down;
                    }
                    break;
                }
            }
            actb_rangeu = 1;
            actb_ranged = j - 1;
            actb_display = true;
            if (actb_pos <= 0) actb_pos = 1;
        }
        function actb_remake() {
            document.body.removeChild(document.getElementById('tat_table'));
            a = document.createElement('table');
            a.cellSpacing = '1px';
            a.cellPadding = '2px';
            //a.style.position = 'absolute';
            a.addClass('absolutePos');
            a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + "px";
            a.style.left = curLeft(actb_curr) + "px";
            a.style.backgroundColor = actb_self.actb_bgColor;
            a.style.width = actb_self.actb_fwidth;
            a.id = 'tat_table';
            if (actb_self.actb_mouse) {
                a.onmouseout = actb_table_unfocus;
                a.onmouseover = actb_table_focus;
            }
            document.body.appendChild(a);
            var i;
            var first = true;
            var j = 1;
            if (actb_rangeu > 1) {
                r = a.insertRow(-1);
                r.style.backgroundColor = actb_self.actb_bgColor;
                r.style.width = actb_self.actb_fwidth;
                c = r.insertCell(-1);
                c.style.color = actb_self.actb_textColor;
                //c.style.fontFamily = 'arial narrow';
                c.addClass('fontstyle1');
                c.style.fontSize = actb_self.actb_fSize;
                //c.align = 'center';
                c.addClass('a-center');
                replaceHTML(c, '/\\');
                if (actb_self.actb_mouse) {
                    //c.style.cursor = 'pointer';
                    c.addClass('pointer');
                    c.onclick = actb_mouse_up;
                }
            }
            for (i = 0; i < actb_self.actb_keywords.length; i++) {
                if (actb_bool[i]) {
                    if (j >= actb_rangeu && j <= actb_ranged) {
                        r = a.insertRow(-1);
                        r.style.backgroundColor = actb_self.actb_bgColor;
                        r.style.width = actb_self.actb_fwidth;
                        r.id = 'tat_tr' + (j);
                        c = r.insertCell(-1);
                        c.style.color = actb_self.actb_textColor;
                        c.style.fontFamily = actb_self.actb_fFamily;
                        c.style.fontSize = actb_self.actb_fSize;
                        c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
                        c.id = 'tat_td' + (j);
                        c.setAttribute('pos', j);
                        if (actb_self.actb_mouse) {
                            //c.style.cursor = 'pointer';
                            c.addClass('pointer');
                            c.onclick = actb_mouseclick;
                            c.onmouseover = actb_table_highlight;
                        }
                        j++;
                    } else {
                        j++;
                    }
                }
                if (j > actb_ranged) break;
            }
            if (j - 1 < actb_total) {
                r = a.insertRow(-1);
                r.style.backgroundColor = actb_self.actb_bgColor;
                r.style.width = actb_self.actb_fwidth;
                c = r.insertCell(-1);
                c.style.color = actb_self.actb_textColor;
                //c.style.fontFamily = 'arial narrow';
                c.addClass('fontstyle1');
                c.style.fontSize = actb_self.actb_fSize;
                //c.align = 'center';
                c.addClass('a-center');
                replaceHTML(c, '\\/');
                if (actb_self.actb_mouse) {
                    //c.style.cursor = 'pointer';
                    c.addClass('pointer');
                    c.onclick = actb_mouse_down;
                }
            }
        }
        function actb_goup() {
            if (!actb_display) return;
            if (actb_pos == 1) return;
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;
            actb_pos--;
            if (actb_pos < actb_rangeu) actb_moveup();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_godown() {
            if (!actb_display) return;
            if (actb_pos == actb_total) return;
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos++;
            if (actb_pos > actb_ranged) actb_movedown();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_movedown() {
            actb_rangeu++;
            actb_ranged++;
            actb_remake();
        }
        function actb_moveup() {
            actb_rangeu--;
            actb_ranged--;
            actb_remake();
        }

        /* Mouse */
        function actb_mouse_down() {
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos++;
            actb_movedown();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            actb_curr.focus();
            actb_mouse_on_list = 0;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_mouse_up(evt) {
            if (!evt) evt = event;
            if (evt.stopPropagation) {
                evt.stopPropagation();
            } else {
                evt.cancelBubble = true;
            }
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos--;
            actb_moveup();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            actb_curr.focus();
            actb_mouse_on_list = 0;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_mouseclick(evt) {
            if (!evt) evt = event;
            if (!actb_display) return;
            actb_mouse_on_list = 0;
            actb_pos = this.getAttribute('pos');
            actb_penter();
        }
        function actb_table_focus() {
            actb_mouse_on_list = 1;
        }
        function actb_table_unfocus() {
            actb_mouse_on_list = 0;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_table_highlight() {
            actb_mouse_on_list = 1;
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos = this.getAttribute('pos');
            while (actb_pos < actb_rangeu) actb_moveup();
            while (actb_pos > actb_ranged) actb_movedown();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        /* ---- */

        function actb_insertword(a) {
            if (actb_self.actb_delimiter.length > 0) {
                str = '';
                l = 0;
                for (i = 0; i < actb_delimwords.length; i++) {
                    if (actb_cdelimword == i) {
                        prespace = postspace = '';
                        gotbreak = false;
                        for (j = 0; j < actb_delimwords[i].length; ++j) {
                            if (actb_delimwords[i].charAt(j) != ' ') {
                                gotbreak = true;
                                break;
                            }
                            prespace += ' ';
                        }
                        for (j = actb_delimwords[i].length - 1; j >= 0; --j) {
                            if (actb_delimwords[i].charAt(j) != ' ') break;
                            postspace += ' ';
                        }
                        str += prespace;
                        str += a;
                        l = str.length;
                        if (gotbreak) str += postspace;
                    } else {
                        str += actb_delimwords[i];
                    }
                    if (i != actb_delimwords.length - 1) {
                        str += actb_delimchar[i];
                    }
                }
                actb_curr.value = str;
                setCaret(actb_curr, l);
            } else {
                actb_curr.value = a;
            }
            actb_mouse_on_list = 0;
            actb_removedisp();
        }
        function actb_penter() {
            if (!actb_display) return;
            actb_display = false;
            var word = '';
            var c = 0;
            for (var i = 0; i <= actb_self.actb_keywords.length; i++) {
                if (actb_bool[i]) c++;
                if (c == actb_pos) {
                    word = actb_self.actb_keywords[i];
                    break;
                }
            }
            actb_insertword(word);
            l = getCaretStart(actb_curr);
        }
        function actb_removedisp() {
            if (actb_mouse_on_list == 0) {
                actb_display = 0;
                if (document.getElementById('tat_table')) { document.body.removeChild(document.getElementById('tat_table')); }
                if (actb_toid) clearTimeout(actb_toid);
            }
        }
        function actb_keypress(e) {
            if (actb_caretmove) stopEvent(e);
            return !actb_caretmove;
        }
        function actb_checkkey(evt) {


            if (!evt) evt = event;
            a = evt.keyCode;
            caret_pos_start = getCaretStart(actb_curr);
            actb_caretmove = 0;
            switch (a) {
                case 38:
                    actb_goup();
                    actb_caretmove = 1;
                    return false;
                    break;
                case 40:
                    actb_godown();
                    actb_caretmove = 1;
                    return false;
                    break;
                case 13: case 9:
                    if (actb_display) {
                        actb_caretmove = 1;
                        actb_penter();
                        return false;
                    } else {
                        return true;
                    }
                    break;
                default:
                    setTimeout(function() { actb_tocomplete(a) }, 50);
                    break;
            }
        }

        function actb_tocomplete(kc) {

            if (kc == 38 || kc == 40 || kc == 13) return;
            var i;
            if (actb_display) {
                var word = 0;
                var c = 0;
                for (var i = 0; i <= actb_self.actb_keywords.length; i++) {
                    if (actb_bool[i]) c++;
                    if (c == actb_pos) {
                        word = i;
                        break;
                    }
                }
                actb_pre = word;
            } else { actb_pre = -1 };

            if (actb_curr.value == '') {
                actb_mouse_on_list = 0;
                actb_removedisp();
                return;
            }
            if (actb_self.actb_delimiter.length > 0) {
                caret_pos_start = getCaretStart(actb_curr);
                caret_pos_end = getCaretEnd(actb_curr);

                delim_split = '';
                for (i = 0; i < actb_self.actb_delimiter.length; i++) {
                    delim_split += actb_self.actb_delimiter[i];
                }
                delim_split = delim_split.addslashes();
                delim_split_rx = new RegExp("([" + delim_split + "])");
                c = 0;
                actb_delimwords = new Array();
                actb_delimwords[0] = '';

                for (i = 0, j = actb_curr.value.length; i < actb_curr.value.length; i++, j--) {
                    if (actb_curr.value.substr(i, j).search(delim_split_rx) == 0) {
                        ma = actb_curr.value.substr(i, j).match(delim_split_rx);
                        actb_delimchar[c] = ma[1];
                        c++;
                        actb_delimwords[c] = '';
                    } else {
                        actb_delimwords[c] += actb_curr.value.charAt(i);
                    }
                }

                var l = 0;
                actb_cdelimword = -1;
                for (i = 0; i < actb_delimwords.length; i++) {
                    if (caret_pos_end >= l && caret_pos_end <= l + actb_delimwords[i].length) {
                        actb_cdelimword = i;
                    }
                    l += actb_delimwords[i].length + 1;
                }
                var ot = actb_delimwords[actb_cdelimword].trim();
                var t = actb_delimwords[actb_cdelimword].addslashes().trim();
            } else {
                var ot = actb_curr.value;
                var t = actb_curr.value.addslashes();
            }
            if (ot.length == 0) {
                actb_mouse_on_list = 0;
                actb_removedisp();
            }
            if (ot.length < actb_self.actb_startcheck) return this;
            if (actb_self.actb_firstText) {
                var re = new RegExp("^" + t, "i");
            } else {
                var re = new RegExp(t, "i");
            }

            actb_total = 0;
            actb_tomake = false;
            actb_kwcount = 0;
            for (i = 0; i < actb_self.actb_keywords.length; i++) {
                actb_bool[i] = false;
                if (re.test(actb_self.actb_keywords[i])) {
                    actb_total++;
                    actb_bool[i] = true;
                    actb_kwcount++;
                    if (actb_pre == i) actb_tomake = true;
                }
            }

            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
            actb_generate();
        }
        return this;
    }
    //petchi
    function ProductItemsSelected(source, eventArgs) {
        var Product = eventArgs.get_text().split('^^');
        document.getElementById('ProductSearch1_txtProduct').value = Product[0];

    }
</script>
<table class="w-100p" >
    <tr>
        <td class="w-10p a-left">
           <asp:Label ID="lblselectcat" runat="server" Text="Select Category" 
                meta:resourcekey="lblselectcatResource1"></asp:Label> :
        </td>
        <td class="w-20p">
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCategory" CssClass="hide"
                runat="server" meta:resourcekey="txtCategoryResource1"></asp:TextBox>
            <asp:DropDownList ID="ddlCategory" runat="server"  CssClass="small"
                meta:resourcekey="ddlCategoryResource1" >
            </asp:DropDownList>
            
        </td>
        <td class="w-14p a-left">
   <asp:Label ID="lblprod" runat="server" Text="Product" 
                meta:resourcekey="lblprodResource1"></asp:Label> :
        </td>
        <td class="a-left">
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProduct" CssClass="small" runat="server" 
                meta:resourcekey="txtProductResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
            CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
            CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
            MinimumPrefixLength="2"  ServiceMethod="GetSearchProductList"
            ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtProduct" 
                DelimiterCharacters="" Enabled="True" OnClientItemSelected="ProductItemSelected">
            </ajc:AutoCompleteExtender>
            <img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" 
                meta:resourcekey="btnSearchResource1" />
        </td>
    </tr>
    <tr>
        <td colspan="5" class="a-center hide" id="tdlist">
            <asp:ListBox ID="listSearch" Visible="False" runat="server"
                 onClick="javascript:SetProductItem(this.id);" 
                meta:resourcekey="listSearchResource1" ></asp:ListBox>
        </td>
    </tr>
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
</table>
<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        LoadAutoCompleteSource('<%= txtCategory.ClientID%>', '<%= ddlCategory.ClientID%>');
    });
   
    function LoadAutoCompleteSource(txtID,ddlID) {
        document.getElementById(txtID).value = document.getElementById(ddlID).options[document.getElementById(ddlID).selectedIndex].text;
        var ddlCatgoryArray = new Array();
        if (document.getElementById(ddlID).innerText != undefined && document.getElementById(ddlID).innerText != null) {
            ddlCatgoryArray = document.getElementById(ddlID).innerText.replace("--Select category--", "").trim().split(' ');
            var objOut = actb(document.getElementById(txtID), ddlCatgoryArray);
        }
    }
    
</script>



