var pno = 1;
var sort = 0;
var filter = 0;
var col = 2;
var searchtext;
var totalCount = 0;
var uid = "";
var rowPid = 0;
var gid = "";
var atid = "";
var atsid = "";
var projid = 0;
var pjname = "";


function callPage(pageno) {
    pno = pageno;
    LoadData();
}


function LoadData() {
    totalCount = $('#hdnTotalCount').val();
    var SessionID = $('#ddlSession option:selected').val();
    var WardID = $('#ddlWardName option:selected').val();
    $('#divLoadingGif').show();
    var orgID = $('#hdnOrgID').val();
    fnGetFoodOrderedList(orgID, SessionID, WardID, pno, totalCount);
}

function fnGetFoodOrderedList(OrgID, SessionID, WardID, pno, TotalRows) {
    $.ajax({
        type: "POST",
        url: "../PagingService.asmx/ProcessFoodDeliveredDetails",
        data: "{ 'OrgID': '" + OrgID + "','SessionID': '" + SessionID + "','WardID': '" + WardID + "','pno': '" + pno + "','totalRows': '" + TotalRows + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function(data) {
            var Items = data.d;
            fnBindFoodRows(Items)
        },
        failure: function(msg) {

            var userMsg = SListForApplicationMessages.Get('CommonControls\\Qualification.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('error');
                return false;
            }
        }
    });
}

function fnBindFoodRows(Items) {
    $('#gvFoodDeliveredDetails').empty();
    $('#gvFoodDeliveredDetails').append('<tr class="dataheader1"><th scope="col">Select</th><th scope="col">Ward Name</th><th scope="col">Food Ordered Date</th><th scope="col">Food Name</th><th scope="col">Status</th><th scope="col">UOM</th><th scope="col">Total Quantity</th></tr>');
    $.each(Items, function(index, Item) {
    $('#gvFoodDeliveredDetails').append('<tr><td><input type="checkbox" onclick="GetDeliveringDetails(this)" id="chk" RI="' + Item.Rowid + '"  FI="' + Item.FoodOrdersID + '" /></td><td>' + Item.WardName + '</td><td>' + JSONDateWithTime(Item.FoodOrderDate) + '</td><td>' + Item.FoodName + '</td><td>' + Item.OrderStatus + '</td><td>' + Item.UOM + '</td><td>' + Item.TotalQuantity + '</td></tr>');
    });
    MakeChkBoxSelect();
    createPager(totalCount, $('#divPager'));
    $('#divLoadingGif').hide();
}


function JSONDateWithTime(dateStr) {
    jsonDate = dateStr;
    var d = new Date(parseInt(jsonDate.substr(6)));
    var m, day;
    m = d.getMonth() + 1;
    if (m < 10)
        m = '0' + m
    if (d.getDate() < 10)
        day = '0' + d.getDate()
    else
        day = d.getDate();
    var formattedDate = m + "/" + day + "/" + d.getFullYear();
    var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
    var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d.getMinutes();
    var formattedTime = hours + ":" + minutes + ":" + d.getSeconds();
    formattedDate = formattedDate + " " + formattedTime;
    return formattedDate;
}


function createPager(count, id) {
    var lastPno = ((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1);
    $(id).html('');
    if (count != 0) {
        totalCount = count;
        var aFirst, aPrev;
        if (pno == 1) {
            aPrev = $("<a id=\"aP\" style=\"margin-left:5px;\" tabindex=\"12\"></a>");
            $(aPrev).html('Prev');
            aFirst = $("<a id=\"aF\" tabindex=\"11\"></a>");
            $(aFirst).html('&lt;&lt;');
        }
        else {
            aPrev = $("<a id=\"aP\" style=\"cursor:pointer;margin-left:5px;\" tabindex=\"12\"></a>");
            $(aPrev).html('Prev');
            $(aPrev).click(function() {
                callPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
            });
            $(aPrev).keypress(function() {
                if (event.keyCode == 13) {
                    callPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
                }
            });
            aFirst = $("<a id=\"aF\" style=\"cursor:pointer;\" tabindex=\"11\"></a>");
            $(aFirst).click(function() {
                callPage(1);
            });

            $(aFirst).keypress(function(event) {
                if (event.keyCode == 13) {
                    callPage(1);
                }
            });
            aFirst.html('&lt;&lt;');
        }
        $(id).append(aFirst);
        var newSpace1 = $("<span>");
        $(newSpace1).html('&nbsp&nbsp');
        $(id).append(newSpace1);
        $(id).append(aPrev);
        var newSpace2 = $("<span>");
        $(newSpace2).html('&nbsp&nbsp');
        $(id).append(newSpace2);
        if (pno > 2 && (count / 10) > 3) {
            var newDots = $("<span>");
            $(newDots).html('...');
            $(id).append(newDots);
            var newSpace = $("<span>");
            $(newSpace).html('&nbsp&nbsp');
            $(id).append(newSpace);
        }
        for (var i = 1; i <= ((count % 10) == 0 ? (count / 10) : (count / 10) + 1); i++) {
            var forCond1 = (parseInt(pno) + 2);
            if (parseInt(pno) == 1) {
                forCond1 = (parseInt(pno) + 3);
            }
            var forCond2 = parseInt(i) + 2;
            if (parseInt(pno) == parseInt((count % 10) == 0 ? (count / 10) : (count / 10) + 1)) {
                forCond2 = parseInt(i) + 3;
            }
            if ((parseInt(pno)) < forCond2 && forCond1 > parseInt(i)) {
                var newA
                if (pno == i) {
                    newA = $("<a id=\"a" + i + "\" style=\"cursor:pointer;\" tabindex=\"12\"></a>");
                    //$(newA).attr('class', 'Selected');
                    $(newA).addClass('Selected');
                }
                else {
                    newA = $("<a id=\"a" + i + "\" style=\"cursor:pointer;\" tabindex=\"12\"></a>");
                    $(newA).click(function() {
                        var cRow = this.id.split('a')[1];
                        callPage(cRow);
                    });
                    $(newA).keypress(function() {
                        if (event.keyCode == 13) {
                            var cRow = this.id.split('a')[1];
                            callPage(cRow);
                        }
                    });
                }
                $(newA).html(i);
                var newSpace = $("<span></span>");
                $(newSpace).html('&nbsp&nbsp');
                $(id).append(newA);
                $(id).append(newSpace);
            }
        }
        if ((parseInt(pno) + 1) < (count / 10) && (count / 10) > 3) {
            var newDots = $("<span></span>");
            $(newDots).html('...');
            $(id).append(newDots);
            var newSpace = $("<span></span>");
            $(newSpace).html('&nbsp&nbsp');
            $(id).append(newSpace);
        }
        var aLast, aNext;
        if (pno == ((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1)) {
            aLast = $("<a id=\"aL\" tabindex=\"13\"></a>");
            $(aLast).html('&gt;&gt;');

            aNext = $("<a id=\"aN\" style=\"margin-right:5px;\" tabindex=\"12\"></a>");
            $(aNext).html('Next');

        }
        else {
            aLast = $("<a id=\"aL\" style=\"cursor:pointer;margin-right:5px;\" tabindex=\"13\"></a>");
            $(aLast).html('&gt;&gt;');
            $(aLast).click(function() {
                callPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
            });
            $(aLast).keypress(function(event) {
                if (event.keyCode == 13) {
                    callPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
                }
            });
            aNext = $("<a id=\"aN\" style=\"cursor:pointer;margin-right:5px;\" tabindex=\"12\"></a>");
            $(aNext).html('Next');
            $(aNext).click(function() {
                callPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
            });
            $(aNext).keypress(function(event) {
                if (event.keyCode == 13) {
                    callPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
                }
            });
        }
        $(id).append(aNext);
        var newSpace4 = $("<span></span>");
        $(newSpace4).html('&nbsp&nbsp');
        $(id).append(newSpace4);
        $(id).append(aLast);
    }
}