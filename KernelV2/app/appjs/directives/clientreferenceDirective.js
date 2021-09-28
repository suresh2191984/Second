angular.module('attuneKernel.directives')
.directive('clientreferenceDirective', function (DataFactory) {
    return {
        controller: ['$scope', '$rootScope', 'billingAPI', function ($scope, $rootScope, billingAPI) {
            $scope.clientDetails = {};            
            var getClietnDetailsLoaded = function (data, error) {
                if (error) {
                    return false;
                }
                $scope.clientData = data;
                $scope.clientDetails.Client = data.Client;
                $scope.ClientCopy = data.Client;
                //$scope.clientData.SamplePickupDate = new Date();
                $scope.clientData.VisiTypeCode = $.grep(data.VisiType, function (n, i) { return (n.Code == '0') })[0].Code;
            }
            var getClientAttributesFieldDetails = function (data, error) {
                if (error) {
                    return false;
                }
                $scope.clientData.Client.ClientAttributes = data;
            }
            billingAPI.getClientDetails(getClietnDetailsLoaded);
           
            $scope.getClient = function (prefix) {
                return DataFactory.get('client', { PrefixText: prefix }, false)
                    .then(function (response) {
                        return response.data.map(function (item) {
                            return item;
                        });
                    });
            };
            $scope.GetClientAttributesFieldDetails = function () {
                if ($scope.clientDetails && $scope.clientDetails.Client) {
                    billingAPI.getClientAttributesFieldDetails($scope.clientData.Client.ClientID, "CLIENT", getClientAttributesFieldDetails);
                }
            }
            $scope.setDefaultClient = function (data) {
                if (!angular.isObject(data)) {
                    $scope.clientDetails.Client = $scope.ClientCopy;
                    $scope.clientData.TPA = $scope.ClientCopy;
                }
            };
            $scope.billingClear = function () {
                $rootScope.billingDetailsClear();
            };
            $scope.getReferringHosp = function (prefix) {
                return DataFactory.get('referringhospital', { PrefixText: prefix, ClientId: $scope.clientDetails.Client.ClientID }, false)
                    .then(function (response) {
                        return response.data.map(function (item) {
                            return item;
                        });
                    });
                if ($scope.clientDetails && $scope.clientDetails.Client) {
                    billingAPI.getReferinghospital(searchtext, $scope.clientDetails.Client.ClientID, referinghsp);
                }
            };

            $scope.getreferingphysician = function (prefix) {
                return DataFactory.get('referringphysician', { ClientId: $scope.clientDetails.Client.ClientID, PrefixText: prefix }, false)
                    .then(function (response) {
                        return response.data.map(function (item) {
                            return item;
                        });
                    });
            };

            //--phlebotomist ail

            $scope.getPhlebotomist = function (prefix) {
                return DataFactory.get('phlebotomist', { SearchText: prefix }, false)
                    .then(function (response) {
                        return response.data.map(function (item) {
                            return item;
                        });
                    });
            };

            $scope.$watch('clientData.TPA', function (newobj, oldobj) {
                if (newobj  && newobj.ClientID>0){
                    $scope.GetClientAttributesFieldDetails()
                }
            });

            $scope.knowledge = function () {
                billingAPI.clientdata_knowledgeData = $scope.Knowledge_data;
            };

            /*
            //calender popup 
            $scope.openCalender = function () {
                $scope.dateOptions.opened = true;
            };

            $scope.dateOptions = {
                opened: false,
                formatYear: 'yyyy',
                // maxDate: new Date(),
            };*/
        }],

        templateUrl: '../KernelV2/app/template/directives/clientreferenceDirective.html',
        restrict: 'AE',
        scope: {
            clientData: '=clientdata'
        }
    };
})

