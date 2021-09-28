angular.module('attuneKernel.directives')
.directive('paymentDirective', function () {
    return {
        controller: ['$scope', 'DataFactory', 'masterdataAPI', 'Notification', function ($scope, DataFactory, masterdataAPI, Notification) {
            $scope.Payment = {};
            $scope.dirOptions = {};
            $scope.NetAmount;
            $scope.TotalAmountReceived = 0;
            var payment_func = function (data, error) {
                if (error) {
                    return false;
                }
                $scope.objpayment = data;                
                $scope.Payment.CurrencyID = $.grep($scope.objpayment.Currency, function (n, i) { return n.CurrencyCode == "INR" })[0].CurrencyID;
                $scope.Payment.BaseCurrencyID = $scope.Payment.CurrencyID;
                $scope.Payment.PaymentType = $.grep($scope.objpayment.PaymentType, function (n, i) { return n.PaymentName == "Cash"; })[0];

            }
            var totalAmountReceived = function () {
                angular.forEach($scope.billDetails.AmountReceivedDetails, function (payment, index) {
                });
            }

            $scope.$watch('NetAmount', function (newValue, oldValue) {
                if ($scope.clientData && $scope.clientData.IsCashClient == 'Y') {
                    $scope.Payment.AmtReceived = $scope.NetAmount;
                }
                else {
                    $scope.Payment.AmtReceived = 0;
                }
                if (!angular.isUndefined($scope.billDetails.AmountReceivedDetails) && $scope.billDetails.AmountReceivedDetails.length > 0) {
                    Notification.error({ message: 'Net Amount changed Payment control was cleared', title: 'Alert' })
                    $scope.billDetails.AmountReceivedDetails = [];
                }

            });

            masterdataAPI.getpaymentdetails(payment_func);

            $scope.getbank = function (bank) {
                return DataFactory.get('bank', { SearchText: bank }, false).then(function (response) {
                    return response.data.map(function (item) {
                        return item;
                    });
                });
            };

            $scope.AmountReceived = function (bank) {

                var alert = $scope.options.AddAmountReceived();
                if (alert == "Payment type already") {
                    Notification.error({ message: 'Payment type already exisit', title: '<i><u>Error</u></i>' });
                }
                else if (alert == "Same Type Bank Card") {
                    Notification.error({ message: 'Same Card No and Bank against payment type not Allowed', title: '<i><u>Error</u></i>' });
                }
                else if (alert == "Provide Less than amount") {
                    Notification.error({ message: 'Same Card No and Bank against payment type not Allowed', title: '<i><u>Error</u></i>' });
                }
                else if (alert == "BankNameorCardType") {
                    Notification.error({ message: 'Provide Bank Name', title: '<i><u>Error</u></i>' });
                }
                else if (alert == "ChequeorCardNumber") {
                    Notification.error({ message: 'Provide Cheque Number or Card Number', title: '<i><u>Error</u></i>' });
                }
                else if (alert == "ChequeValidDate") {
                    Notification.error({ message: 'Provide Cheque Valid Date', title: '<i><u>Error</u></i>' });
                }
            };

            $scope.deleteAmountRow = function (index) {
                $scope.billDetails.AmountReceived = $scope.billDetails.AmountReceived - $scope.billDetails.AmountReceivedDetails[index].AmtReceived;
                $scope.billDetails.AmountRefund = $scope.billDetails.AmountRefund - $scope.billDetails.AmountRefund
                $scope.billDetails.Due = $scope.billDetails.Due - $scope.billDetails.Due;
                $scope.billDetails.AmountReceivedDetails.splice(index, 1);

            };

        }],
        templateUrl: '../KernelV2/app/template/directives/paymentDirective.html',
        restrict: 'E',
        replace: true,
        scope: {
            options: '=options',
            billDetails: '=billdetails',
            NetAmount: '=netamount',
            clientData:'=clientdata'
        },

        link: function (scope) {
            scope.directiveCtrlCalled = false;
            angular.extend(scope.options, {
                AddAmountReceived: function () {
                    if (!scope.billDetails.AmountReceivedDetails) {
                        scope.billDetails.AmountReceivedDetails = [];
                        scope.billDetails.AmountReceived = 0;
                        scope.billDetails.AmountRefund = 0;
                        scope.billDetails.Due = 0;

                    }
                    var exbool = false; var msg;
                    if (scope.Payment.PaymentType.PaymentName == "Cheque") {
                        if (angular.isUndefined(scope.Payment.BankNameorCardType)) {
                            exbool = true;
                            msg = "BankNameorCardType";
                        }
                        if (angular.isUndefined(scope.Payment.ChequeorCardNumber)) {
                            exbool = true;
                            msg = "ChequeorCardNumber";
                        }
                        if (angular.isUndefined(scope.Payment.ChequeValidDate)) {
                            exbool = true;
                            msg = "ChequeValidDate";
                        }
                    }
                    else if (scope.Payment.PaymentType.PaymentName == "Credit/Debit Card" || scope.Payment.PaymentType.PaymentName == "Demand Draft" ||
                        scope.Payment.PaymentType.PaymentName == "MASTER" || scope.Payment.PaymentType.PaymentName == "MAESTRO" ||
                        scope.Payment.PaymentType.PaymentName == "Coupon" || scope.Payment.PaymentType.PaymentName == "Credit Note"
                        ) {
                        if (angular.isUndefined(scope.Payment.BankNameorCardType)) {
                            exbool = true;
                            msg = "BankNameorCardType";
                        }
                        if (angular.isUndefined(scope.Payment.ChequeorCardNumber)) {
                            exbool = true;
                            msg = "ChequeorCardNumber";
                        }
                    }

                    angular.forEach(scope.billDetails.AmountReceivedDetails, function (payment, index) {
                        if (payment.PaymentType.PaymentName === "Cash" && scope.Payment.PaymentType.PaymentName == "Cash") {
                            exbool = true;
                            msg = "Payment type already";
                        }
                        else if (payment.PaymentType.PaymentName == scope.Payment.PaymentType.PaymentName) {
                            if (payment.BankNameorCardType.BankID == scope.Payment.BankNameorCardType.BankID) {
                                if (payment.ChequeorCardNumber === scope.Payment.ChequeorCardNumber) {
                                    exbool = true;
                                    msg = "Same Type Bank Card";
                                }
                            }
                        }
                    });
                    if (exbool) {
                        return msg;
                    }

                    if (!exbool) {
                        if (parseInt(parseInt(scope.billDetails.AmountReceived) + parseInt(scope.Payment.AmtReceived)) > parseInt(scope.NetAmount) && scope.Payment.PaymentType.PaymentName != "Cash") {
                            msg = "Provide Less than amount";
                            return msg;
                        }
                        scope.billDetails.AmountReceived = parseInt(scope.billDetails.AmountReceived) + parseInt(scope.Payment.AmtReceived);
                        scope.Payment.OtherCurrencyAmount = scope.billDetails.AmountReceived;
                        scope.Payment.BaseCurrencyID = $.grep(scope.objpayment.Currency, function (n, i) { return n.CurrencyCode == "INR" })[0].CurrencyID;
                        scope.Payment.PaidCurrencyID = scope.Payment.BaseCurrencyID;
                        scope.Payment.PaymentType = scope.Payment.PaymentType;
                        scope.Payment.TypeID = scope.Payment.PaymentType.PaymentTypeID;
                        if (parseInt(scope.billDetails.AmountReceived) > parseInt(scope.NetAmount) && scope.Payment.PaymentType.PaymentName == "Cash") {
                            scope.billDetails.AmountRefund = parseInt(scope.billDetails.AmountRefund) + (parseInt(scope.billDetails.AmountReceived) - parseInt(scope.NetAmount));
                            scope.billDetails.Due = 0;
                        }
                        else if (parseInt(scope.billDetails.AmountReceived) < parseInt(scope.NetAmount)) {
                            scope.billDetails.Due = parseInt(scope.NetAmount) - parseInt(scope.billDetails.AmountReceived);
                        }
                        if (scope.billDetails.AmountRefund > 0) {
                            scope.TotalAmountReceived = scope.billDetails.AmountReceived - scope.billDetails.AmountRefund;
                        }
                        else {
                            scope.TotalAmountReceived = scope.billDetails.AmountReceived
                        }
                        scope.billDetails.AmountReceivedDetails.push(scope.Payment);
                        scope.Payment = {};
                        scope.Payment.BaseCurrencyID = $.grep(scope.objpayment.Currency, function (n, i) { return n.CurrencyCode == "INR" })[0].CurrencyID;
                        scope.Payment.PaymentType = $.grep(scope.objpayment.PaymentType, function (n, i) { return n.PaymentName == "Cash"; })[0];
                    }
                },
                ClearAmountReceived: function () {
                    delete scope.billDetails["AmountReceivedDetails"]
                }
            });
        }
    };
})



