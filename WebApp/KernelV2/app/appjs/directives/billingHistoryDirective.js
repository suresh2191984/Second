angular.module('attuneKernel.directives')
.directive('billingHistoryDirective', ['DataFactory', '$compile', 'Notification',
		function (DataFactory, $compile, Notification) {
		    return {
		        controller: function ($scope) {

		            $scope.GetComplaint = function (prefix, type) {
		                return DataFactory.get('GetComplaint', { searchText: prefix }, false)
                            .then(function (response) {
                                return response.data.map(function (item) {
                                    return item;
                                });
                            });
		            };

		            $scope.addComplaint = function () {

		                if (!chkHistDuplicate())
		                {
		                    if(!$scope.lsthistory.History)
		                    {
		                        $scope.lsthistory.History=[];
		                    }
		                    $scope.lsthistory.History.push($scope.Complaint);
		                    $scope.Complaint = '';
		                }
		                else {
		                    Notification.error({ message: 'Item Already Exists !', title: 'Alert' });
		                    return false;
		                }
                
		            }

		            $scope.addPreference = function () {
		                if ($scope.Preferences.Preference) {
		                    if (!chkPrefDuplicate()) {
		                        if (!$scope.lsthistory.PatientPreference) {
		                            $scope.lsthistory.PatientPreference = [];
		                        }

		                        $scope.lsthistory.PatientPreference.push(angular.copy($scope.Preferences));
		                        $scope.Preferences.Preference = '';
		                    }
		                    else {
		                        Notification.error({ message: 'Item Already Exists !', title: 'Alert' });
		                        return false;
		                    }
		                }
		            }
		            $scope.deletePreference = function (index) {
		                $scope.lsthistory.PatientPreference.splice(index, 1);
		            }
		            $scope.deleteComplaint = function (index) {
		                $scope.lsthistory.History.splice(index, 1);
		            }


		            $scope.clearFiles = function () {

		            }
		            var chkHistDuplicate = function () {
		                var isBool = false;
		                if (!$scope.lsthistory)
		                {
		                    $scope.lsthistory = {};
		                    $scope.lsthistory.History = [];
		                }
		                angular.forEach($scope.lsthistory.History, function (hist, index) {
		                    if (hist.ICDDescription == $scope.Complaint.ICDDescription) {
		                        isBool = true;
		                      }
		                });
		                return isBool;
		            }

		            var chkPrefDuplicate = function () {
		                var isBool = false;
		                if (!$scope.lsthistory) {
		                    $scope.lsthistory = {};
		                    $scope.lsthistory.PatientPreference = [];
		                }
		                angular.forEach($scope.lsthistory.PatientPreference, function (pre, index) {
		                    if (pre.Preference == $scope.Preference) {
		                        isBool = true;
		                    }
		                });
		                return isBool;
		            }
		        },
		        templateUrl: '../KernelV2/app/template/directives/billingPatientHistory.html',
		        link: function (scope, elem, attrs) {
		            //if ($rootScope.ViewParts != undefined) {
		            //    var pageData = Enumerable.From($rootScope.ViewParts).Where(function (x) {
		            //        return x.RefID == 5
		            //    }).Select(function (x) {
		            //        return x.Html
		            //    }).FirstOrDefault();
		            //    var compiled = $compile(pageData)(scope);
		            //    var box = "#dynContent";
		            //    angular.element(box).append(compiled);
		            //}
		        },
		        restrict: 'AE',
		        scope: {
		            lsthistory: '=lsthistory'
		        }
		    };

		}
]);
