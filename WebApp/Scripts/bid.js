// JavaScript Document

var selectedRowId;
var currentRowId;
var previousRowId;

function showhideBid(bid, status1, status2) {
    var obj1 = document.getElementById(bid);
    var obj2 = document.getElementById(status1);
    var obj3 = document.getElementById(status2);
    if (obj1.style.display == 'none') {
        obj1.style.display = 'block';
        obj2.style.display = 'block';
        obj3.style.display = 'none';
    }
    else {
        obj1.style.display = 'none';
        obj2.style.display = 'none';
        obj3.style.display = 'block';

    }
}


function showhideBid1(topBid, bottomBid) {
    var obj1 = document.getElementById(topBid);
    var obj2 = document.getElementById(bottomBid);
    if (obj1.style.display == 'block') {
        obj1.style.display = 'none';
        obj2.style.display = 'block';
    }
    else {
        obj1.style.display = 'block';
        obj2.style.display = 'none';
    }
}

function showResponses(plusImg, minusImg, responses, status) {
    var obj1 = document.getElementById(plusImg);
    var obj2 = document.getElementById(minusImg);
    var obj3 = document.getElementById(responses);
    if (status == 1) {
        obj3.style.display = 'table-row';
        obj2.style.display = 'table';
        obj1.style.display = 'none';
    }
    else if (status == 2) {
        obj3.style.display = 'table-row';
        obj2.style.display = 'table';
        obj1.style.display = 'none';
    }
	 //changes by arun - when user view the TRF image after that if user view the report, it shows in the half screen resolution fixes
    else if (status == 3) {
        obj3.style.display = 'table';
        obj2.style.display = 'table';
        obj1.style.display = 'none';
    }
    else {
        obj3.style.display = 'none';
        obj2.style.display = 'none';
        obj1.style.display = 'table';
    }
	//changes by arun - when user view the TRF image after that if user view the report, it shows in the half screen resolution fixes
    if (status == 1 && responses == "ACX3responses2" && minusImg == "ACX3minus2" && plusImg == "ACX3plus2") {
        obj3.style.display = 'table';
    }
}

function showuserResponses(plusImg, minusImg, responses,editHide, status) {
    var obj1 = document.getElementById(plusImg);
    var obj2 = document.getElementById(minusImg);
    var obj3 = document.getElementById(responses);
    var obj4 = document.getElementById(editHide);
    var obj5 = document.getElementById('ACX2plusEU');
    var obj6 = document.getElementById('ACX2minusEU'); 
    if (status == 1) {
        obj3.style.display = 'table';
        obj2.style.display = 'table';
        obj1.style.display = 'none';
    }
    else if (status == 2) {
        obj3.style.display = 'table-row';
        obj2.style.display = 'table';
        obj1.style.display = 'none';
        obj4.style.display = 'none';
        obj5.style.display = 'table';
        obj6.style.display = 'none';
    }
    else {
        obj3.style.display = 'none';
        obj2.style.display = 'none';
        obj1.style.display = 'table';
    }
}


function v() {
    var InformationMsg;
    var Error;
    $(document).ready(function() {
    Error = SListForAppMsg.Get("Scripts_Header_Alert") != null ? SListForAppMsg.Get("Scripts_Header_Alert") : "Alert";
    InformationMsg = SListForAppMsg.Get("Scripts_bid_js_01") != null ? SListForAppMsg.Get("Scripts_bid_js_01") : "aaaaven";
    });
    ValidationWindow(InformationMsg + '  ' + length, Error);

   // alert('aaaaven');
}

function showBidHistory(bids, bidBottom) {
    var bids = document.getElementById(bids);
    //var picklist=document.getElementById(pklist);
    var bidBottom = document.getElementById(bidBottom);
    if (bids.style.display == 'none' || bidBottom.style.display == 'none') {
        bids.style.display = 'block';
        bidBottom.style.display = 'block';
    }
    else {
        bids.style.display = 'none';
        bidBottom.style.display = 'none';

    }

}

function showPickList(bids, bidBottom) {
    var bids = document.getElementById(bids);
    var bidBottom = document.getElementById(bidBottom);
    if (bids.style.display == 'none' || bidBottom.style.display == 'none') {
        bids.style.display = 'block';
        bidBottom.style.display = 'block';
    }
    else {
        bids.style.display = 'none';
        bidBottom.style.display = 'none';
    }

}

function showhidePickList(projid, bid1, bid2) {
    var projid = document.getElementById(projid);
    var bid1 = document.getElementById(bid1);
    var bid2 = document.getElementById(bid2);
    if (projid.checked == true) {
        bid1.style.display = 'block';
        bid2.style.display = 'none';
    }
    else {
        bid1.style.display = 'none';
        bid2.style.display = 'none';
    }
}

function showhidePickList1(projid, bid1, bid2) {
    var projid = document.getElementById(projid);
    var bid1 = document.getElementById(bid1);
    var bid2 = document.getElementById(bid2);
    if (projid.checked == true) {
        bid1.style.display = 'block';
        bid2.style.display = 'block';
    }
    else {
        bid1.style.display = 'none';
        bid2.style.display = 'none';
    }
}

function showBid(bid, status1, status2) {
    var obj1 = document.getElementById(bid);
    var obj2 = document.getElementById(status1);
    var obj3 = document.getElementById(status2);
    obj1.style.display = 'block';
    obj2.style.display = 'block';
    obj3.style.display = 'none';
}

function changeColor1(tagId, rowStyleName) {
    var obj = document.getElementById(tagId);
    //		obj.className=rowStyleName;
    if (tagId == selectedRowId) {
        obj.className = 'selectedRow';
    }
    else
    { obj.className = rowStyleName; }
}

function changeColor2(tagId, rowStyleName) {
    var obj = document.getElementById(tagId);
    if (tagId == selectedRowId) {
        obj.className = 'selectedRow';
    }
    else
    { obj.className = rowStyleName; }
}

function selectedRow(tagId, rowStyleName) {

    if (currentRowId != tagId) {
        selectedRowId = tagId;
        if (previousRowId == null) {
            previousRowId = tagId;
            currentRowId = tagId;
            var sClname = document.getElementById(currentRowId);
            sClname.className = rowStyleName;
        }
        else {
            previousRowId = currentRowId;
            currentRowId = tagId;
            selectedRowId = tagId;
            var i = previousRowId.substr(3, 1);
            if ((i % 2) == 0) {
                var clName = document.getElementById(previousRowId);
                clName.className = 'bidHistoryRow1';
            }
            else {
                var clName = document.getElementById(previousRowId);
                clName.className = 'bidHistoryRow2';
            }
            var clName1 = document.getElementById(currentRowId);
            clName1.className = rowStyleName;
        }
    }
}
function showResponsesTable(plusImg, minusImg, responses, status) {
    if (status == 1) {
        $('#' + responses).removeClass().addClass("hide");
        $('#' + minusImg).removeClass().addClass("show");
        $('#' + plusImg).removeClass().addClass("hide");
    }
    else {
        $('#' + responses).removeClass().addClass("displaytb w-100p");
        $('#' + minusImg).removeClass().addClass("hide");
        $('#' + plusImg).removeClass().addClass("show");
    }
}

function showResponsesRow(plusImg, minusImg, responses, status) {
    if (status == 1) {
        $('#' + responses).removeClass().addClass("panelContent");
        $('#' + minusImg).removeClass().addClass("show");
        $('#' + plusImg).removeClass().addClass("hide");
    }
    else {
        $('#' + responses).removeClass().addClass("hide");
        $('#' + minusImg).removeClass().addClass("hide");
        $('#' + plusImg).removeClass().addClass("show");
    }
}
