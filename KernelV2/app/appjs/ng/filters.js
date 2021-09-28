'use strict';

angular.module('attuneKernel.filters', [])
.filter('truncate', function () {
	return function (text, length, end) {
		if (text == undefined)
			return;
		if (isNaN(length))
			length = 10;

		if (end === undefined)
			end = "...";

		if (text.length <= length || text.length - end.length <= length) {
			return text;
		} else {
			return String(text).substring(0, length - end.length) + end;
		}

	};
})
.filter('dateformat', function ($filter) {
	return function (input) {
		if (input == null) {
			return "";
		}
		if (new Date(input).getFullYear() == 10000) {
			return "";
		}
		var _date = $filter('date')(new Date(input), _dateFormat);
		return _date;
	};
})
.filter('monthformat', function ($filter) {
	return function (input) {
		if (input == null) {
			return "";
		}
		if (new Date(input).getFullYear() == 10000) {
			return "";
		}
		var _date = $filter('date')(new Date(input), "MMM/yyyy");
		return _date;
	};
})
.filter('timeformat', function ($filter) {
	return function (input) {
		if (input == null) {
			return "";
		}
		var _date = $filter('date')(new Date(input), _timeFormat.replace('tt', 'a'));
		return _date;
	};
})
.filter('datetimeformat', function ($filter) {
	return function (input) {
		if (input == null) {
			return "";
		}
		var _date = $filter('date')(new Date(input), _dateTimeFormat.replace('tt', 'a'));
		return _date;
	};
})
.filter('IsNullOrEmptyField', function () {
	return function (array) {
		var filteredArray = [];
		angular.forEach(array, function (item) {
			if (item.field_value != '' && item.field_value != null && item.field_type != 'image')
				filteredArray.push(item);
		});
		return filteredArray;
	};
}).filter("decimal2", function () {
	return function (val) {
		return val.toFixed(2);
	};
})
.filter('newline', function () {
	return function (text) {
		if (text != undefined)
			return text.replace(/\n/g, '<br/>');
		return text;
	};
})
.filter('TemplateStatus', function () {
	return function (text) {
		if (text == 1)
		{
			return 'Active'
			} else if (text == 2){
				return 'Draft' } else{
					return 'Inactive'}
	};
})
.filter('startFrom', function () {
	return function (data, start) {
		try {
			return data.slice(start);
		} catch (Error) {}
	}
})

.filter('unique', function() {
    return function(collection, primaryKey) { //no need for secondary key
      var output = [], 
          keys = [];
          var splitKeys = primaryKey.split('.'); //split by period


      angular.forEach(collection, function(item) {
            var key = {};
            angular.copy(item, key);
            for(var i=0; i<splitKeys.length; i++){
                key = key[splitKeys[i]];    //the beauty of loosely typed js :)
            }

            if(keys.indexOf(key) === -1) {
              keys.push(key);
              output.push(item);
            }
      });

      return output;
    };
});

				