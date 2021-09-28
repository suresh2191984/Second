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
        obj3.style.display = 'block';
        obj2.style.display = 'block';
        obj1.style.display = 'none';        
    }
    else {        
        obj3.style.display = 'none';
        obj2.style.display = 'none';
        obj1.style.display = 'block';        
    }
}

function v() {
    alert('aaaaven');
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

