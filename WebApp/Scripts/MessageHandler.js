/*
File to handle User / Error message read from Resource file, parse and construct them into an Array. 
This File has to be included at the TOP of client side coding of EVERY page (where there is an error / user message displayed).
The Global variable at the top will take the Key=Value pairs from the Hidden variable of each page, parse and Load them as array. 
*/
var SListForApplicationMessages; //For displaying application messages

function SortedList() {
    this.innerList = new Array();

    this.Set = function(key, value) {
        this.innerList[key] = value;
    }

    // The Load function does the Parsing and Constuction of the Array
    this.Load = function(preLoadValues) {
        ////debugger;
       
        for (var i = 0; i < preLoadValues.length; i++) {
            this.Set(preLoadValues[i].Code, preLoadValues[i].DisplayText);
        }
    }

    this.Exist = function(key) {
        return typeof (this.innerList[key]) != 'undefined';
    }

    // Gets the Value for the specified Key passed
    this.Get = function(key) {
        // //debugger;
        var val = this.innerList[key];
        if (typeof (val) == 'undefined') return null;
        return val;
    }
}

SListForAppMsg = new SortedList();
SListForAppMsg.Load(Att_ResourceKey_AppMsg);
SListForAppDisplay = new SortedList();
SListForAppDisplay.Load(Att_ResourceKey_AppDisplay);
