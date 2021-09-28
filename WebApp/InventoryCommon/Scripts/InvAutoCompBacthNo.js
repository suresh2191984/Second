

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
    this.actb_bgColor = '#ccc';
    this.actb_fwidth = '93px';
    this.actb_textColor = '#fff';
    this.actb_hColor = '#008080';
    this.actb_fFamily = 'Verdana';
    this.actb_fSize = '12px';
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
        a.style.position = 'absolute';
        a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + "px";
        a.style.left = curLeft(actb_curr) + "px";
        a.style.backgroundColor = actb_self.actb_bgColor;
        a.style.width = actb_self.actb_fwidth;
        a.id = 'tat_table';
        document.body.appendChild(a);
        if (actb_curr.value.length > 1) {
            document.getElementById('tat_table').style.display = 'table';
        }
        if (actb_curr.value.length < 1) {
            document.getElementById('tat_table').style.display = 'none';
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
                c = r.insertCell(0);
                c.style.color = actb_self.actb_textColor;
                c.style.fontFamily = actb_self.actb_fFamily;
                c.style.fontSize = actb_self.actb_fSize;
                c.innerHTML = actb_parse(actb_self.actb_keywords[i].split("@#$")[0]);
                c.id = 'tat_td' + (j);
                c.setAttribute('pos', j);
                if (actb_self.actb_mouse) {
                    c.style.cursor = 'pointer';
                    c.onclick = actb_mouseclick;
                    c.onmouseover = actb_table_highlight;
                }
                q = r.insertCell(1);
                q.style.color = actb_self.actb_textColor;
                q.style.fontFamily = actb_self.actb_fFamily;
                q.style.fontSize = actb_self.actb_fSize;
                q.style.display = "none";
                q.innerHTML = actb_keywords[i].split("@#$")[1];
                q.id = 'tat_td' + (j);
                q.setAttribute('pos', j);
                if (actb_self.actb_mouse) {
                    q.style.cursor = 'pointer';
                    q.onclick = actb_mouseclick;
                    q.onmouseover = actb_table_highlight;
                }
                j++;
            }
            if (j - 1 == actb_self.actb_lim && j < actb_total) {
                r = a.insertRow(-1);
                r.style.backgroundColor = actb_self.actb_bgColor;
                r.style.width = actb_self.actb_fwidth;
                c = r.insertCell(0);
                c.style.color = actb_self.actb_textColor;
                c.style.fontFamily = 'arial narrow';
                c.style.fontSize = actb_self.actb_fSize;
                c.align = 'center';
                replaceHTML(c, '\\/');
                if (actb_self.actb_mouse) {
                    c.style.cursor = 'pointer';
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
        a.style.position = 'absolute';
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
            c = r.insertCell(0);
            c.style.color = actb_self.actb_textColor;
            c.style.fontFamily = 'arial narrow';
            c.style.fontSize = actb_self.actb_fSize;
            c.align = 'center';
            replaceHTML(c, '/\\');
            if (actb_self.actb_mouse) {
                c.style.cursor = 'pointer';
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
                    c = r.insertCell(0);
                    c.style.color = actb_self.actb_textColor;
                    c.style.fontFamily = actb_self.actb_fFamily;
                    c.style.fontSize = actb_self.actb_fSize;
                    c.innerHTML = actb_parse(actb_self.actb_keywords[i].split("@#$")[0]);
                    c.id = 'tat_td' + (j);
                    c.setAttribute('pos', j);
                    if (actb_self.actb_mouse) {
                        c.style.cursor = 'pointer';
                        c.onclick = actb_mouseclick;
                        c.onmouseover = actb_table_highlight;
                    }
                    q = r.insertCell(1);
                    q.style.color = actb_self.actb_textColor;
                    q.style.fontFamily = actb_self.actb_fFamily;
                    q.style.fontSize = actb_self.actb_fSize;
                    q.style.display = "none";
                    q.innerHTML = actb_keywords[i].split("@#$")[1];
                    q.id = 'tat_td' + (j);
                    q.setAttribute('pos', j);
                    if (actb_self.actb_mouse) {
                        q.style.cursor = 'pointer';
                        q.onclick = actb_mouseclick;
                        q.onmouseover = actb_table_highlight;
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
            c = r.insertCell(0);
            c.style.color = actb_self.actb_textColor;
            c.style.fontFamily = 'arial narrow';
            c.style.fontSize = actb_self.actb_fSize;
            c.align = 'center';
            replaceHTML(c, '\\/');
            if (actb_self.actb_mouse) {
                c.style.cursor = 'pointer';
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
        var pCell = document.getElementById('tat_tr' + actb_pos).cells[1].innerText;


        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').rows[j].style.backgroundColor = "";
            if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
            }

        }

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
        var pCell = document.getElementById('tat_tr' + actb_pos).cells[1].innerText;
        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').rows[j].style.backgroundColor = "";
            if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
            }

        }
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
        var pCell = document.getElementById('tat_tr' + actb_pos).cells[1].innerText;

        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').rows[j].style.backgroundColor = "";
            if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
            }

        }
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
        var pCell = document.getElementById('tat_tr' + actb_pos).cells[1].innerText;


        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').rows[j].style.backgroundColor = "";
            if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
            }

        }
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
        var pCell = document.getElementById('tat_tr' + actb_pos).cells[1].innerText;


        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').rows[j].style.backgroundColor = "";
            if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
            }

        }
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
            actb_curr.value = str.split("@#$")[0];
            document.getElementById('hdnReceivedID').value = str.split("@#$")[1]
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



function doGetProductTotalQuantity(source, eventArgs) {

    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    $('#tbllist').removeClass().addClass('hide'); 
    if (document.getElementById('txtProduct').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    } else {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tbllist').insertRow(0);
        Headrow.id = "HeadID1";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "responstableHeader w-100p"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
        var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
        var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
        var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
        var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");


        cell1.innerHTML = Product;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = ExpDate;
        cell4.innerHTML = SellingPrice;
        cell5.innerHTML = CostPrice;
        cell6.innerHTML = AvailableQty;
        cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
        var lis = JSON.parse(eventArgs.get_value());
        var sum = 0;
        var pcount = 0;
        $.each(lis, function (obj, value) {
            if (value != "") {
                var tblData = value;
                var pdate = GetServerDate();
                var row = document.getElementById('tbllist').insertRow(obj+1);
                row.id = "tr_par" + tblData.StockInHandID;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                sum += parseFloat(tblData.InHandQuantity);
                cell1.innerHTML = tblData.Name;
                cell2.innerHTML = tblData.BatchNo;
                var DateSplit = (new Date(tblData.ExpiryDate.substr(6))).format("dd/MM/yyyy") == "01/01/1753" ? "**" : (new Date(tblData.ExpiryDate.substr(6))).format("dd/MM/yyyy");
                cell3.innerHTML = DateSplit;
                $('#hdnDisplaydata').val(parseFloat(tblData.SellingPrice).toFixed(2));
                cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata'));

                $('#hdnDisplaydata').val(parseFloat(tblData.CostPrice).toFixed(2));
                cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata'));

                $('#hdnDisplaydata').val(tblData.InHandQuantity);
                cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata')) + "(" + tblData.SellingUnit + ")";
                pcount++;
                cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
            }
        });
        if (pcount > 0) {
            var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
            var fcell1 = fotrow.insertCell(0);
            var fcell2 = fotrow.insertCell(1);
            var fcell3 = fotrow.insertCell(2);
            var fcell4 = fotrow.insertCell(3);
            var fcell5 = fotrow.insertCell(4);
            var fcell6 = fotrow.insertCell(5);
            fotrow.style.align = "right";
            fcell5.innerHTML = "";
            $('#hdnDisplaydata').val(sum.toFixed(2));
            fcell6.innerHTML = "Total   " + ToTargetFormat($('#hdnDisplaydata'));
            fcell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
            $('#tbllist').removeClass().addClass('responstable w-100p'); 
        }

    }
}


function doGetProductTotalQuantityLaundry(source, eventArgs) {

    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    $('#tbllist').removeClass().addClass('hide');
    if (document.getElementById('txtProduct').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    } else {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tbllist').insertRow(0);
        Headrow.id = "HeadID1";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "responstableHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
        var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
        var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");

        cell1.innerHTML = Product;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = ExpDate;
        cell4.innerHTML = AvailableQty;

        var lis = JSON.parse(eventArgs.get_value());
        var sum = 0;
        var pcount = 0;
        $.each(lis, function (obj, value) {
            if (value != "") {
                var tblData = value;
                var pdate = GetServerDate();
                var row = document.getElementById('tbllist').insertRow(1);
                row.id = "tr_par" + tblData.ID;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);

                sum += parseFloat(tblData.InHandQuantity);
                cell1.innerHTML = tblData.Name;
                cell2.innerHTML = tblData.BatchNo;
                //var DateSplit = (new Date(tblData.ExpiryDate.substr(6))).format("dd/MM/yyyy") == "01/01/1753" ? "**" : (new Date(tblData.ExpiryDate.substr(6))).format("dd/MM/yyyy");
                cell3.innerHTML = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy") == "Jan/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy");

                $('#hdnDisplaydata').val(tblData.InHandQuantity);
                cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata')) + "(" + tblData.SellingUnit + ")";
                pcount++;
            }
        });
        if (pcount > 0) {
            var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
            var fcell1 = fotrow.insertCell(0);
            var fcell2 = fotrow.insertCell(1);
            var fcell3 = fotrow.insertCell(2);
            var fcell4 = fotrow.insertCell(3);
            fotrow.style.align = "right";
            $('#hdnDisplaydata').val(sum.toFixed(2));
            fcell4.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
            $('#tbllist').removeClass().addClass('responstable w-100p'); 
        }

    }
}

function PatientGetProductKits(source, eventArgs) {
    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    document.getElementById('tbllist').style.display = "none";
    if (document.getElementById('txtProduct').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    } else {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tbllist').insertRow(0);
        Headrow.id = "HeadID1";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "responstableHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);
        var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
        var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
        var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
        var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
        var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");

        cell1.innerHTML = Product;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = ExpDate;
        cell4.innerHTML = SellingPrice;
        cell5.innerHTML = CostPrice;
        cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
        cell6.innerHTML = AvailableQty;
        // cell7.innerHTML = "<input id='chkAll' name='chkAll' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>SelectAll</input>";
        var lis = eventArgs.get_value().split('^');
        var sum = 0;
        var pcount = 0
        for (i = lis.length - 1; i >= 0; i--) {
            if (lis[i] != "") {
                var tblData = lis[i].split('~');
                //                    tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[0].split('|')[1] + "</td><td align='left'>" + tblData[8].trim().split(' ')[1] + "/" + tblData[8].trim().split(' ')[2] + "</td><td align='right'>" + tblData[3] + "(" + tblData[4] + ")" + "</td></tr>";
                if (tblData[17] == 'Y') {

                    GetKitPrepDetails(tblData[0].split('|')[1], tblData[0].split('|')[0]);
                    document.getElementById('TableProductDetails').style.display = "none";
                }
                else {
                    document.getElementById('TableProductDetails').style.display = "block";
                    document.getElementById('kits').innerHTML = "";
                    var pdate = GetServerDate();
                    pdate = new Date(tblData[8]);
                    var row = document.getElementById('tbllist').insertRow(1);
                    row.style.height = "13px";
                    row.id = "tr_par" + tblData[2];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    sum += parseFloat(tblData[3]);
                    cell1.innerHTML = tblData[1];
                    cell2.innerHTML = tblData[0].split('|')[1];
                    cell3.innerHTML = pdate.format("MMM/yyyy") == "Jan/1753" ? "**" : pdate.format("MMM/yyyy");
                    $('#hdnDisplaydata').val(parseFloat(tblData[5]).toFixed(2));
                    cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
                    $('#hdnDisplaydata').val(parseFloat(tblData[18]).toFixed(2));
                    cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
                    $('#hdnDisplaydata').val(tblData[3]);
                    cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata')) + "(" + tblData[4] + ")";
                    pcount++;
                    cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
                }
            }

        }
        if (pcount > 0) {
            var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
            var fcell1 = fotrow.insertCell(0);
            var fcell2 = fotrow.insertCell(1);
            var fcell3 = fotrow.insertCell(2);
            var fcell4 = fotrow.insertCell(3);            
            var fcell5 = fotrow.insertCell(4);
            var fcell6 = fotrow.insertCell(5);
            fotrow.style.align = "right";
//            if (CostPriceShow == "N") {
//                fcell4.innerHTML = "Total";
//            } else {
//                fcell5.innerHTML = "Total";
            //            }
            fcell5.innerHTML = "";
            fcell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
            $('#hdnDisplaydata').val(sum.toFixed(2));
            fcell6.innerHTML = "Total   " + ToTargetFormat($('#hdnDisplaydata'));
            document.getElementById('tbllist').style.display = "table";
        }

    }
}

function GetDecimalValue(Setvalue) {
    //var digitroundoff = Math.floor(Setvalue * 100) / 100;
    return Setvalue;
}


function BillingGetProductTotalQuantity(source, eventArgs) {

    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    document.getElementById('tbllist').style.display = "none";
    if (document.getElementById('txtProduct').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    } else {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tbllist').insertRow(0);
        Headrow.id = "HeadID1";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "responstableHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = "";
        var cell6 = "";
        var cell7 = "";
        cell5 = Headrow.insertCell(4);
        cell6 = Headrow.insertCell(5);
        cell7 = Headrow.insertCell(6);
        var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
        var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
        var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
        var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
        var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");
        var MRP = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_12") == null ? "MRP/SRP" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_12");

        cell1.innerHTML = Product;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = ExpDate;
        cell4.innerHTML = SellingPrice;
        cell5.innerHTML = CostPrice;
        cell6.innerHTML = MRP;
        cell7.innerHTML = AvailableQty;
        cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
        var lis = eventArgs.get_value().split('^');
        var sum = 0;
        var pcount = 0
        for (i = lis.length - 1; i >= 0; i--) {
            if (lis[i] != "") {
                var tblData = lis[i].split('~');

                var pdate = GetServerDate();
                var arr = tblData[8].split('/');
                var dd = arr[0];
                var MM = arr[1];
                var YYYY = arr[2];
                var pdate1 = ToExternalMonth(tblData[8]);  //arr[1] + "/" + arr[0] + "/" + arr[2]; //("MM/dd/YYYY")
                //pdate = new Date(pdate1);
                
                
                var row = document.getElementById('tbllist').insertRow(1);
                row.style.height = "13px";
                row.id = "tr_par" + tblData[2];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = "";
                var cell6 = "";
                var cell7 = "";
                cell5 = row.insertCell(4);
                cell6 = row.insertCell(5);
                cell7 = row.insertCell(6);

                sum += parseFloat(tblData[3]);
                cell1.innerHTML = tblData[1];
                cell2.innerHTML = tblData[0].split('|')[1];
                cell3.innerHTML = pdate1;//.format("MMM/yyyy") == "Jan/1753" ? "**" : pdate.format("MMM/yyyy");

                var GetValue = '0.00';
                GetValue = GetDecimalValue(tblData[5]);
                // $('#hdnDisplaydata').val(Number(tblData[5]).toFixed(2));
                $('#hdnDisplaydata').val(parseFloat(GetValue).toFixed(2));
                cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata')) == undefined ? parseFloat(GetValue).toFixed(2) : ToTargetFormat($('#hdnDisplaydata'));
                //  $('#hdnDisplaydata').val(parseFloat(tblData[18]).toFixed(2));
                GetValue = GetDecimalValue(tblData[18]);
                $('#hdnDisplaydata').val(parseFloat(GetValue).toFixed(2));
                cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata'));



                GetValue = GetDecimalValue(tblData[27]);
                $('#hdnDisplaydata').val(parseFloat(GetValue).toFixed(2));
                //  $('#hdnDisplaydata').val(parseFloat(tblData[27]).toFixed(2));
                cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata'));

                $('#hdnDisplaydata').val(tblData[3]);
                var batchQty = ToTargetFormat($('#hdnDisplaydata')) == undefined ? tblData[3] : ToTargetFormat($('#hdnDisplaydata'));
                cell7.innerHTML = batchQty + "(" + tblData[4] + ")";
                pcount++;
                cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
            }
        }

        if (pcount > 0) {
            var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
            var fcell1 = fotrow.insertCell(0);
            var fcell2 = fotrow.insertCell(1);
            var fcell3 = fotrow.insertCell(2);
            var fcell4 = fotrow.insertCell(3);
            var fcell5 = "";
            var fcell6 = "";
            var fcell7 = "";
            fcell5 = fotrow.insertCell(4);
            fcell6 = fotrow.insertCell(5);
            fcell5.innerHTML = "";
            fcell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
            $('#hdnDisplaydata').val(sum.toFixed(2));
            var TotalQty = ToTargetFormat($('#hdnDisplaydata')) == undefined ? sum.toFixed(2) : ToTargetFormat($('#hdnDisplaydata'));
            fcell7 = fotrow.insertCell(6);
            fcell7.innerHTML = "Total   " + TotalQty;
            document.getElementById('tbllist').style.display = "table";
        }

    }
}
function StockretTotalQuantity(source, eventArgs) {
    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    document.getElementById('tbllist').style.display = "none";
    if (document.getElementById('txtProduct').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        } 
    } else {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tbllist').insertRow(0);
        Headrow.id = "HeadID1";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "responstableHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);

        var cell5 = Headrow.insertCell(4);
        var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
        var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");
        var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
        var CreatedAtDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_07") == null ? "CreatedAt Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_07");

        cell1.innerHTML = Product;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = CreatedAtDate;
        cell4.innerHTML = SellingPrice;
        cell5.innerHTML = AvailableQty;


        var lis = eventArgs.get_value().split('^');
        var sum = 0;
        var pcount = 0
        for (i = lis.length - 1; i >= 0; i--) {
            if (lis[i] != "") {

                var y = lis[i].split('~');
                var tblData = lis[i].split('~');
                var pdate = GetServerDate();
                pdate = new Date(tblData[8]);

                var row = document.getElementById('tbllist').insertRow(1);
                if (y[16] == 'Y') {
                    row.style.backgroundColor = "Green";
                }

                row.style.height = "13px";
                row.id = "tr_par" + tblData[11];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);

                sum += parseFloat(tblData[5]);
                cell1.innerHTML = tblData[1];
                cell2.innerHTML = tblData[4];
                cell3.innerHTML = tblData[8]; //pdate.format("dd/MMM/yyyy");

                $('#hdnDisplaydata').val(parseFloat(tblData[9]).toFixed(2));
                cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata'));

                $('#hdnDisplaydata').val(tblData[5]);
                cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata')); +"(" + tblData[7] + ")";
                pcount++;
            }


        }
        if (pcount > 0) {
            var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
            var fcell1 = fotrow.insertCell(0);
            var fcell2 = fotrow.insertCell(1);
            var fcell3 = fotrow.insertCell(2);
            var fcell4 = fotrow.insertCell(3);
            var fcell5 = fotrow.insertCell(4);
            var fcell6 = fotrow.insertCell(5);

            fotrow.style.align = "right";
            fcell4.innerHTML = "";
            fcell4.style.display = CostPriceShow == "N" ? "block" : "none";
            $('#hdnDisplaydata').val(sum.toFixed(2));
            fcell6.innerHTML = "Total   " + ToTargetFormat($('#hdnDisplaydata'));
            document.getElementById('tbllist').style.display = "table";
        }

        //        document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';

    }
}


function doClearTable() {
    if (document.getElementById('txtProduct').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    }
}

function InvOpSubTable(tableObj) {

    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    document.getElementById('tbllist').style.display = "none";
    while (count = document.getElementById('tbllist').rows.length) {

        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').deleteRow(j);
        }
    }

    var Headrow = document.getElementById('tbllist').insertRow(0);
    Headrow.id = "HeadID1";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "responstableHeader"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);

    var cell5 = Headrow.insertCell(4);

    var cell6 = Headrow.insertCell(5);
    var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
    var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
    var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
    var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
    var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
    var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");


    cell1.innerHTML = Product;
    cell2.innerHTML = BatchNo;
    cell3.innerHTML = ExpDate;
    cell4.innerHTML = SellingPrice;

    cell5.innerHTML = CostPrice;
    cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
    cell6.innerHTML = AvailableQty;


    var lis = tableObj.split('^');
    var sum = 0;
    var pcount = 0
    for (i = lis.length - 1; i >= 0; i--) {
        if (lis[i] != "") {
            var tblData = lis[i].split('~');
            var pdate = GetServerDate();
            pdate = new Date(tblData[9]);
            var row = document.getElementById('tbllist').insertRow(1);
            row.style.height = "13px";
            row.id = "tr_par" + tblData[3];
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);

            var cell6 = row.insertCell(5);
            sum += parseFloat(tblData[4]);
            cell1.innerHTML = tblData[2];
            cell2.innerHTML = tblData[1];
            //            cell3.innerHTML = pdate.format("MMM/yyyy");
            cell3.innerHTML = pdate.format("MMM/yyyy") == "Jan/1753" ? "**" : pdate.format("MMM/yyyy");

            $('#hdnDisplaydata').val(parseFloat(tblData[6]).toFixed(2));
            cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata'));


            $('#hdnDisplaydata').val(parseFloat(tblData[19]).toFixed(2));
            cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata'));


            $('#hdnDisplaydata').val(tblData[4]);
            cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata')) + "(" + tblData[5] + ")";
            pcount++;
            cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
        }

    }
    if (pcount > 0) {
        var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
        var fcell1 = fotrow.insertCell(0);
        var fcell2 = fotrow.insertCell(1);
        var fcell3 = fotrow.insertCell(2);
        var fcell4 = fotrow.insertCell(3);

        var fcell5 = fotrow.insertCell(4);

        var fcell6 = fotrow.insertCell(5);
        fotrow.style.align = "right";
        //        if (CostPriceShow == "N") {
        //            fcell4.innerHTML = "Total";
        //        } else {

        //        }
        fcell5.innerHTML = "";
        fcell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
        //fcell5.innerHTML = "Total";
        $('#hdnDisplaydata').val(sum.toFixed(2));
        fcell6.innerHTML = "Total   " + ToTargetFormat($('#hdnDisplaydata'));
        document.getElementById('tbllist').style.display = "table";
    }

}


function SalesGetProductTotalQuantity(source, eventArgs) {

    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    document.getElementById('tbllist').style.display = "none";
    if (document.getElementById('txtProductName').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    } else {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tbllist').insertRow(0);
        Headrow.id = "HeadID1";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "responstableHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);

        var cell5 = Headrow.insertCell(4);

        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);
        var cell8 = Headrow.insertCell(7);
        var cell9 = Headrow.insertCell(8);
        var cell10 = Headrow.insertCell(9);
        var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
        var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
        var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
        var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");
        var MRP = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_12") == null ? "MRP/SRP" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_12");
        var UOM = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_13") == null ? "UOM" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_13");
        var MFTCode = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_10") == null ? "MFT.Code" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_10");
        var Rate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_11") == null ? "Rate" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_11");
        var MFTDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_08") == null ? "MFT.Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_08");

        cell1.innerHTML = Product;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = MFTDate;
        cell4.innerHTML = ExpDate;
        cell5.innerHTML = MFTCode;
        cell6.innerHTML = Rate;
        //        if (CostPriceShow == "N") {
        //            // cell5.innerHTML = "Cost Price";
        //        } else {
        cell7.innerHTML = CostPrice;

        //}
        cell8.innerHTML = MRP;
        cell9.innerHTML = UOM;
        cell10.innerHTML = AvailableQty;
        cell7.style.display = CostPriceShow == "N" ? "block" : "none";

        var lis = eventArgs.get_value().split('^');
        var sum = 0;
        var pcount = 0
        for (i = lis.length - 1; i >= 0; i--) {
            if (lis[i] != "") {
                var tblData = lis[i].split('~');
                //                    tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[0].split('|')[1] + "</td><td align='left'>" + tblData[8].trim().split(' ')[1] + "/" + tblData[8].trim().split(' ')[2] + "</td><td align='right'>" + tblData[3] + "(" + tblData[4] + ")" + "</td></tr>";

                var pMFTdate = GetServerDate();
                pMFTdate = new Date(tblData[3]);
                var pdate = GetServerDate();
                pdate = new Date(tblData[4]);
                var row = document.getElementById('tbllist').insertRow(1);
                row.style.height = "13px";
                row.id = "tr_par" + tblData[2];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);

                var cell7 = row.insertCell(6);

                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                sum += parseFloat(tblData[5]);
                cell1.innerHTML = tblData[1];
                cell2.innerHTML = tblData[2];
                cell3.innerHTML = pMFTdate.format("MMM/yyyy");
                cell4.innerHTML = pdate.format("MMM/yyyy");
                cell5.innerHTML = tblData[12];
                $('#hdnDisplaydata').val(parseFloat(tblData[9]).toFixed(2));
                cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
                //                if (CostPriceShow == "N") {
                //                    // cell7.innerHTML = tblData[8];
                //                }
                //                else {
                cell7.innerHTML = parseFloat(tblData[8]).toFixed(2);
                // }

                cell8.innerHTML = parseFloat(tblData[10]).toFixed(2);
                cell9.innerHTML = tblData[7];
                cell10.innerHTML = tblData[5] + "(" + tblData[7] + ")";
                pcount++;
                cell7.style.display = CostPriceShow == "N" ? "block" : "none";
            }

        }
        if (pcount > 0) {
            var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
            var fcell1 = fotrow.insertCell(0);
            var fcell2 = fotrow.insertCell(1);
            var fcell3 = fotrow.insertCell(2);
            var fcell4 = fotrow.insertCell(3);
            var fcell5 = fotrow.insertCell(4);
            var fcell6 = fotrow.insertCell(5);


            var fcell7 = fotrow.insertCell(6);


            var fcell8 = fotrow.insertCell(7);
            var fcell9 = fotrow.insertCell(8);
            var fcell10 = fotrow.insertCell(9);
            fotrow.style.align = "right";
            //            if (CostPriceShow == "N") {
            //                fcell8.innerHTML = "Total";
            //            } else {
            //  fcell9.innerHTML = "Total";
            //}
            fcell9.innerHTML = "";
            fcell9.style.display = CostPriceShow == "N" ? "block" : "none";
            $('#hdnDisplaydata').val(sum.toFixed(2));
            fcell10.innerHTML = "Total   " + ToTargetFormat($('#hdnDisplaydata'));
           // fcell10.innerHTML = "Total   " + sum.toFixed(2);
            document.getElementById('tbllist').style.display = "table";
        }

    }
}


function ProductSupplierlist(source, eventArgs) {

    document.getElementById('tbllist').style.display = "none";
    if (document.getElementById('txtProductName').value.length < 2) {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    } else {
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tbllist').insertRow(0);
        Headrow.id = "HeadID1";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "responstableHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);
        var cell8 = Headrow.insertCell(7);
        var SupplierName = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_14") == null ? "Supplier Name" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_14");
        var ProductName = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_15") == null ? "Product Name" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_15");
        var Unit = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_16") == null ? "Unit" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_16");
        var UnitPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_17") == null ? "UnitPrice" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_17");
        var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
        var Tax = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_19") == null ? "Tax" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_19");
        var Discount = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_20") == null ? "Discount" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_20");
        var StockinhandQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_21") == null ? "Stockinhand Qty" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_21");

        cell1.innerHTML = SupplierName;
        cell2.innerHTML = ProductName;
        cell3.innerHTML = Unit;
        cell4.innerHTML = UnitPrice;
        cell5.innerHTML = SellingPrice;
        cell6.innerHTML = Tax;
        cell7.innerHTML = Discount;
        cell8.innerHTML = StockinhandQty;


        var lis = eventArgs.get_value().split('^');
        var sum = 0;
        var pcount = 0
        for (i = lis.length - 1; i >= 0; i--) {

            if (lis[i] != "") {

                var y = lis[i].split('#');
                var pname = y[0].split('~')[1];
                var sname = y[0].split('~')[3];
                var stockinhand = y[0].split('~')[8];
                for (j = 0; j < y.length; j++) {
                    var tblData = y[j].split('~');

                    if (y[j].split('~')[4] == 'R') {
                        var row = document.getElementById('tbllist').insertRow(1);
                        row.style.height = "13px";
                        row.id = "tr_par" + tblData[11];
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);
                        var cell6 = row.insertCell(5);
                        var cell7 = row.insertCell(6);
                        var cell8 = row.insertCell(7);

                        cell1.innerHTML = sname;

                        cell2.innerHTML = pname;
                        cell3.innerHTML = y[j].split('~')[0];
                        cell4.innerHTML = parseFloat(y[j].split('~')[1].trim()).toFixed(2);
                        cell5.innerHTML = parseFloat(y[j].split('~')[5].trim()).toFixed(2);
                        cell6.innerHTML = parseFloat(y[j].split('~')[6].trim()).toFixed(2);
                        cell7.innerHTML = parseFloat(y[j].split('~')[7].trim()).toFixed(2);
                        cell8.innerHTML = parseFloat(stockinhand).toFixed(2);

                        pcount++;
                    }

                }
                sname = "";
                pname = "";
            }

        }
        if (pcount > 0) {

            document.getElementById('tbllist').style.display = "block";
        }

        //        document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';

    }
}






function BillingGetProductTotalQuantityJSON(source, eventArgs) {
    var lis = JSON.parse(eventArgs.get_value());
    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    var isConsignStock = document.getElementById('hdnisConsignmentStock').value == undefined ? "N" : document.getElementById('hdnisConsignmentStock').value;
    document.getElementById('tbllist').style.display = "none";
    $('#tbllist tr').remove();
    var Headrow = document.getElementById('tbllist').insertRow(0);
    Headrow.id = "HeadID1";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "responstableHeader"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = "";
    var cell6 = "";
    var cell7 = "";
    cell5 = Headrow.insertCell(4);
    cell6 = Headrow.insertCell(5);
    cell7 = Headrow.insertCell(6);
    var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
    var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
    var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
    var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
    var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
    var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");
    var MRP = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_12") == null ? "MRP/SRP" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_12");

    cell1.innerHTML = Product;
    cell2.innerHTML = BatchNo;
    cell3.innerHTML = ExpDate;
    cell4.innerHTML = SellingPrice;
    cell5.innerHTML = CostPrice;
    cell6.innerHTML = MRP;
    cell7.innerHTML = AvailableQty;
    cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
    cell4.style.display = isConsignStock == "Y" ? "none" : "table-cell";
    cell6.style.display = isConsignStock == "Y" ? "none" : "table-cell";

    var sum = 0;
    var pcount = 0;
    if (lis.length == 1 && lis[0].StockReceivedBarcodeID > 0) {
        Select_Product_List(JSON.stringify(lis));
        return;
    }
    $.each(lis, function(obj, value) {
        var pdate = GetServerDate();

        var row = document.getElementById('tbllist').insertRow(obj + 1);
        row.style.height = "13px";
        row.id = "tr_par" + value.StockInHandID;
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = "";
        var cell6 = "";
        var cell7 = "";
        cell5 = row.insertCell(4);
        cell6 = row.insertCell(5);
        cell7 = row.insertCell(6);

        sum += parseFloat(value.Quantity);
        cell1.innerHTML = value.ProductName;
        cell2.innerHTML = value.BatchNo;
        cell3.innerHTML = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy") == "Jan/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy");

        var GetValue = '0.00';
        GetValue = GetDecimalValue(value.SellingPrice);
        $('#hdnDisplaydata').val(parseFloat(GetValue).toFixed(2));
        cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata')) == undefined ? parseFloat(GetValue).toFixed(2) : ToTargetFormat($('#hdnDisplaydata'));

        GetValue = GetDecimalValue(value.UnitPrice);
        $('#hdnDisplaydata').val(parseFloat(GetValue).toFixed(2));
        cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata'));

        GetValue = GetDecimalValue(value.MRP);
        $('#hdnDisplaydata').val(parseFloat(GetValue).toFixed(2));
        cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata'));

        $('#hdnDisplaydata').val(value.Quantity);
        var batchQty = ToTargetFormat($('#hdnDisplaydata')) == undefined ? value.Quantity : ToTargetFormat($('#hdnDisplaydata'));
        cell7.innerHTML = batchQty + "(" + value.SellingUnit + ")";
        pcount++;
        cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
        cell4.style.display = isConsignStock == "Y" ? "none" : "table-cell";
        cell6.style.display = isConsignStock == "Y" ? "none" : "table-cell";
    });

    if (pcount > 0) {
        var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
        var fcell1 = fotrow.insertCell(0);
        var fcell2 = fotrow.insertCell(1);
        var fcell3 = fotrow.insertCell(2);
        var fcell4 = fotrow.insertCell(3);
        var fcell5 = "";
        var fcell6 = "";
        var fcell7 = "";
        fcell5 = fotrow.insertCell(4);
        fcell6 = fotrow.insertCell(5);
        fcell5.innerHTML = "";
        fcell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
        fcell4.style.display = isConsignStock == "Y" ? "none" : "table-cell";
        fcell6.style.display = isConsignStock == "Y" ? "none" : "table-cell";
        $('#hdnDisplaydata').val(sum.toFixed(2));
        var TotalQty = ToTargetFormat($('#hdnDisplaydata')) == undefined ? sum.toFixed(2) : ToTargetFormat($('#hdnDisplaydata'));
        fcell7 = fotrow.insertCell(6);
        fcell7.innerHTML = "Total   " + TotalQty;
        document.getElementById('tbllist').style.display = "table";
    }


}
function doGetProductTotalQuantityCommonJSON(source, eventArgs) {

    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    $('#tbllist').removeClass().addClass('hide');
    $('#tbllist tr').remove();

    var Headrow = document.getElementById('tbllist').insertRow(0);
    Headrow.id = "HeadID1";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "responstableHeader w-100p"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
    var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
    var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
    var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
    var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
    var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");


    cell1.innerHTML = Product;
    cell2.innerHTML = BatchNo;
    cell3.innerHTML = ExpDate;
    cell4.innerHTML = SellingPrice;
    cell5.innerHTML = CostPrice;
    cell6.innerHTML = AvailableQty;
    cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
    var lis = JSON.parse(eventArgs.get_value());
    var sum = 0;
    var pcount = 0
    $.each(lis, function (obj, value) {
        var row = document.getElementById('tbllist').insertRow(obj + 1);
        row.id = "tr_par" + value.StockInHandID;
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        sum += parseFloat(value.InHandQuantity);
        cell1.innerHTML = value.ProductName;
        cell2.innerHTML = value.BatchNo;
        cell3.innerHTML = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy") == "Jan/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy");
        $('#hdnDisplaydata').val(parseFloat(value.SellingPrice).toFixed(2));
        cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
        $('#hdnDisplaydata').val(parseFloat(value.UnitPrice).toFixed(2));
        cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
        $('#hdnDisplaydata').val(value.InHandQuantity);
        cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata')) + "(" + value.SellingUnit + ")";
        pcount++;
        cell5.style.display = CostPriceShow == "N" ? "table-cell" : "none";
    });
    if (pcount > 0) {
        var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
        var fcell1 = fotrow.insertCell(0);
        var fcell2 = fotrow.insertCell(1);
        var fcell3 = fotrow.insertCell(2);
        var fcell4 = fotrow.insertCell(3);
        var fcell5 = fotrow.insertCell(4);
        var fcell6 = fotrow.insertCell(5);
        fotrow.style.align = "right";
        fcell5.innerHTML = "";
        $('#hdnDisplaydata').val(sum.toFixed(2));
        fcell6.innerHTML = "Total   " + ToTargetFormat($('#hdnDisplaydata'));
        fcell5.style.display = CostPriceShow == "N" ? "block" : "none";
        $('#tbllist').removeClass().addClass('responstable w-100p');
    }
}


function OnSelectBarcodeProductTotalQuantityCommonJSON(arrSelectedlist) {

    var CostPriceShow = document.getElementById('hdnShowCostPrice').value;
    $('#tbllist').removeClass().addClass('hide');
    $('#tbllist tr').remove();

    var Headrow = document.getElementById('tbllist').insertRow(0);
    Headrow.id = "HeadID1";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "responstableHeader w-100p"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var Product = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01") == null ? "Product" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_01");
    var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_02");
    var ExpDate = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03") == null ? "Exp. Date" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_03");
    var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_04");
    var CostPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05") == null ? "Cost Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_05");
    var AvailableQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06") == null ? "Available Qty." : SListForAppDisplay.Get("InventoryCommon_Scripts_InvAutoCompBacthNo_js_06");


    cell1.innerHTML = Product;
    cell2.innerHTML = BatchNo;
    cell3.innerHTML = ExpDate;
    cell4.innerHTML = SellingPrice;
    cell5.innerHTML = CostPrice;
    cell6.innerHTML = AvailableQty;
    cell5.style.display = CostPriceShow == "N" ? "block" : "none";
    var lis = arrSelectedlist;
    var sum = 0;
    var pcount = 0
    $.each(lis, function(obj, value) {
        var row = document.getElementById('tbllist').insertRow(obj + 1);
        row.id = "tr_par" + value.StockInHandID;
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        sum += parseFloat(value.InHandQuantity);
        cell1.innerHTML = value.ProductName;
        cell2.innerHTML = value.BatchNo;
        cell3.innerHTML = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy") == "Jan/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("MMM/yyyy");
        $('#hdnDisplaydata').val(parseFloat(value.SellingPrice).toFixed(2));
        cell4.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
        $('#hdnDisplaydata').val(parseFloat(value.UnitPrice).toFixed(2));
        cell5.innerHTML = ToTargetFormat($('#hdnDisplaydata'));
        $('#hdnDisplaydata').val(value.InHandQuantity);
        cell6.innerHTML = ToTargetFormat($('#hdnDisplaydata')) + "(" + value.SellingUnit + ")";
        pcount++;
        cell5.style.display = CostPriceShow == "N" ? "block" : "none";
    });
    if (pcount > 0) {
        var fotrow = document.getElementById('tbllist').insertRow(pcount + 1);
        var fcell1 = fotrow.insertCell(0);
        var fcell2 = fotrow.insertCell(1);
        var fcell3 = fotrow.insertCell(2);
        var fcell4 = fotrow.insertCell(3);
        var fcell5 = fotrow.insertCell(4);
        var fcell6 = fotrow.insertCell(5);
        fotrow.style.align = "right";
        fcell5.innerHTML = "";
        $('#hdnDisplaydata').val(sum.toFixed(2));
        fcell6.innerHTML = "Total   " + ToTargetFormat($('#hdnDisplaydata'));
        fcell5.style.display = CostPriceShow == "N" ? "block" : "none";
        $('#tbllist').removeClass().addClass('responstable w-100p');
    }
}