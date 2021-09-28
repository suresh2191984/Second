// INSTRUCTIONS:
// 1. Whenever injecting any service or param into the controllers/functions update them into minification safe injection array as well

'use strict';
angular.module('attuneKernel.directives', [])
.directive('focusMe', ['$timeout', '$parse', function ($timeout, $parse) {
    return {

        link: function (scope, element, attrs) {
            var model = $parse(attrs.focusMe);
            scope.$watch(model, function (value) {
                if (value === true) {
                    $timeout(function () {
                        element[0].focus();
                    });
                }
            });

            element.bind('blur', function () {
                scope.$apply(model.assign(scope, false));
            });
        }
    };
}])
.directive('numericOnly', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attr, ngModelCtrl) {
            function fromUser(text) {
                if (text) {
                    // if (text.replace(/[^0-9^.]/g, '').indexOf('..') == -1) {
                    var transformedInput = text.replace(/[^0-9]/g, '');
                    if (transformedInput !== text) {
                        ngModelCtrl.$setViewValue(transformedInput);
                        ngModelCtrl.$render();
                    }
                    return transformedInput;
                    // }
                    // else {
                    //     var subtransformedInput = text.replace(/[^0-9^.]/g, '');
                    //     //subtransformedInput = subtransformedInput.replace(subtransformedInput.substring(subtransformedInput.length() - 1), "");
                    //     //subtransformedInput = subtransformedInput.charAt(subtransformedInput.length() - 1);
                    //     subtransformedInput = subtransformedInput.substring(0, subtransformedInput.length() - 1)
                    //     if (transformedInput !== text) {
                    //         ngModelCtrl.$setViewValue(subtransformedInput);
                    //         ngModelCtrl.$render();
                    //     }
                    //     return subtransformedInput;
                    // }
                }
                return undefined;
            }
            ngModelCtrl.$parsers.push(fromUser);
        }
    };
})
.directive('capitalize', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, modelCtrl) {
            var capitalize = function (inputValue) {
                if (inputValue == undefined) inputValue = '';
                var capitalized = inputValue.toUpperCase();
                if (capitalized !== inputValue) {
                    // see where the cursor is before the update so that we can set it back
                    var selection = element[0].selectionStart;
                    modelCtrl.$setViewValue(capitalized);
                    modelCtrl.$render();
                    // set back the cursor after rendering
                    element[0].selectionStart = selection;
                    element[0].selectionEnd = selection;
                }
                return capitalized;
            }
            modelCtrl.$parsers.push(capitalize);
            capitalize(scope[attrs.ngModel]); // capitalize initial value
        }
    };
})
.directive('dateTimePicker', function () {
    return {

        template: '<div class="input-group"><span class="input-group-addon" ng-click="click()"><i class="glyphicon glyphicon-calendar"  ></i></span><input type="text" class="form-control input-sm h-26-imp w-110p" placeholder="{{dtplaceholder}}" uib-datepicker-popup="{{format}}"  ng-change=updateDatepicker() uib-datepicker-popup ng-model="dtOutput" is-open="isOpen.opened" datepicker-options="dateOptions" ng-required="true" name="{{dtName}}" close-text="Close"   ng-click="click()" /></div>',
        restrict: 'AE',
        scope: {
            dt: '=ngModel',
            dtOutput: '@ngModel',
            dtmaxDate:"@dtmaxdate"
        },
        controller: function ($scope) {
            $scope.opened = false;
            $scope.minDate = new Date(1950, 1, 1);
            $scope.maxDate = new Date();
            if ($scope.dtmaxDate) {
                $scope.maxDate = new Date("30/12/2999");
            }
            $scope.dateOptions = {
                timepicker: true,
                showweeks: false,
                minDate: $scope.minDate,
                maxDate: $scope.maxDate,
                dateFormat: 'dd/MM/yyyy hh:mm:ss'
            };
            $scope.isOpen = {
                opened: false
            };
            $scope.format = 'dd/MM/yyyy';
            $scope.click = function () {
                $scope.isOpen.opened = true;
            };
            $scope.$watch('dt', function (newobj, oldobj) {
                if (newobj == "" || newobj == undefined || newobj == '9999-12-31T23:59:59.997') {
                    $scope.dtOutput = "";
                } else {
                    $scope.dtOutput = new Date($scope.dt);
                }
            });
            $scope.updateDatepicker = function () {
                $scope.dt = $scope.dtOutput;
            };
        },
        link: function (scope, element, attribute) {
            scope.dtName = attribute.name == undefined ? "dtName" : attribute.name;
            scope.format = attribute.format == undefined ? "dd/MM/yyyy" : attribute.format;
            scope.dtplaceholder = attribute.placeholder == undefined ? "dd/MM/yyyy" : attribute.placeholder;
            
        }
    };
})
.directive("customPopover", ["$popover", "$compile", function ($popover, $compile) {
    return {
        restrict: "A",
        scope: true,
        controller: ['$scope', '$filter', '$timeout', '$sce', function ($scope, $filter, $timeout, $sce) {
        }],
        link: function (scope, element, attrs) {
            var myPopover = $popover(element, {
                contentTemplate: "../KernelV2/app/template/popover/" + attrs.popTemplate + ".html",
                html: true,
                trigger: 'manual',
                autoClose: true,
                transclude: true,
                placement: attrs.popPlacement === undefined ? "bottom" : attrs.popPlacement,
                scope: scope,
                customClass: attrs.popGrouping + " " + (attrs.popDyncss === undefined ? "" : attrs.popDyncss),
                container: attrs.popContainer === undefined ? "body" : attrs.popContainer,
                isOpen: true
            });
            scope.showPopover = function () {
                //scope.Master = {};
                //scope.Master = angular.copy(item);                
                myPopover.toggle();
            }
            scope.hidePopover = function () {
                //scope.objInvestigations.InvestigationValue = scope.Master.objInvestigations.InvestigationValue;
                //$(document.querySelectorAll('.popover-bg')).removeClass("popover-bg");
                myPopover.toggle();
            }
            scope.btnCatch = function () {
                $(document.querySelectorAll('.popover-bg')).removeClass("popover-bg");
                myPopover.toggle();
            }
        }
    }
}])
.directive("decimals", function ($filter) {
    return {
        restrict: "A", // Only usable as an attribute of another HTML element
        require: "?ngModel",
        scope: {
            decimals: "@",
            decimalPoint: "@"
        },
        link: function (scope, element, attr, ngModel) {
            var decimalCount = parseInt(scope.decimals) || 2;
            var decimalPoint = scope.decimalPoint || ".";

            // Run when the model is first rendered and when the model is changed from code
            ngModel.$render = function () {
                if (ngModel.$modelValue !== null && ngModel.$modelValue >= 0 && ngModel.$modelValue != "") {
                    if (typeof decimalCount === "number") {
                        element.val(ngModel.$modelValue.toFixed(decimalCount).toString().replace(",", "."));
                    } else {
                        element.val(ngModel.$modelValue.toString().replace(",", "."));
                    }
                }
            }

            // Run when the view value changes - after each keypress
            // The returned value is then written to the model
            ngModel.$parsers.unshift(function (newValue) {
                if (typeof decimalCount === "number") {
                    var floatValue = parseFloat(newValue.replace(",", "."));
                    if (decimalCount === 0) {
                        return parseInt(floatValue);
                    }
                    return parseFloat(floatValue.toFixed(decimalCount));
                }

                return parseFloat(newValue.replace(",", "."));
            });

            // Formats the displayed value when the input field loses focus
            element.on("change", function (e) {
                var floatValue = parseFloat(element.val().replace(",", "."));
                if (!isNaN(floatValue) && typeof decimalCount === "number") {
                    if (decimalCount === 0) {
                        element.val(parseInt(floatValue));
                    } else {
                        var strValue = floatValue.toFixed(decimalCount);
                        element.val(strValue.replace(".", decimalPoint));
                    }
                }
            });
        }
    }
})
.directive("limitTo", [function () {
    return {
        restrict: "A",
        link: function (scope, elem, attrs) {
            var limit = parseInt(attrs.limitTo);
            angular.element(elem).on("keypress", function (e) {
                if (this.value.length == limit) e.preventDefault();
            });
        }
    }
}]).directive('disableRightClick', function () {
    return {
        restrict: 'A',
        link: function (scope, element, attr) {
            element.bind('contextmenu', function (e) {
                e.preventDefault();
            })
        }
    }
})
.directive('demoFileModel', function ($parse) {
    return {
        restrict: 'A', //the directive can be used as an attribute only

        /*
         link is a function that defines functionality of directive
         scope: scope associated with the element
         element: element on which this directive used
         attrs: key value pair of element attributes
         */
        link: function (scope, element, attrs) {
            var model = $parse(attrs.demoFileModel),
                modelSetter = model.assign; //define a setter for demoFileModel

            //Bind change event on the element
            element.bind('change', function () {
                //Call apply on scope, it checks for value changes and reflect them on UI
                scope.$apply(function () {
                    //set the model value
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
})
.directive('ngFileModel', ['$parse', function ($parse) {
    return {
        restrict: 'A',
        controller: ['$scope', '$filter', '$timeout', '$sce', function ($scope, $filter, $timeout, $sce) {            
            $scope.upload = function () {
                alert($scope.files.length + " files selected ... Write your Upload Code");
            }
        }],
        link: function (scope, element, attrs) {
            var model = $parse(attrs.ngFileModel);
            var isMultiple = attrs.multiple;
            var modelSetter = model.assign;
            element.bind('change', function () {
                var values = [];
                angular.forEach(element[0].files, function (item) {
                    var value = {
                        // File Name 
                        name: item.name,
                        //File Size 
                        size: item.size,
                        //File URL to view 
                        url: URL.createObjectURL(item),
                        // File Input Value 
                        _file: item
                    };
                    values.push(value);
                });
                scope.$apply(function () {
                    if (isMultiple) {
                        modelSetter(scope, values);
                    } else {
                        modelSetter(scope, values[0]);
                    }
                });
            });
        }
    };
}]);