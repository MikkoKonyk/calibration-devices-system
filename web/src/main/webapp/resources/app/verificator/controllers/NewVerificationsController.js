angular
    .module('verificatorModule')
    .controller('NewVerificationsController', ['$scope', '$log', '$modal', 'VerificationService',
        function ($scope, $log, $modal, verificationService) {

            $scope.totalItems = 0;
            $scope.currentPage = 1;
            $scope.itemsPerPage = 10;
            $scope.pageData = [];

            /**
             * get page
             */
            $scope.onTableHandling = function () {
                verificationService
                    .getNewVerifications($scope.currentPage, $scope.itemsPerPage)
                    .success(function (verifications) {
                        $scope.pageData = verifications.content;
                        $scope.totalItems = verifications.totalItems;
                    });
            };

            $scope.onTableHandling();
            /**
             * open modal
             */
            $scope.openDetails = function ($index) {
                $modal.open({
                    animation: true,
                    templateUrl: '/resources/app/verificator/views/modals/new-verification-details.html',
                    controller: 'DetailsModalController',
                    size: 'lg',
                    resolve: {
                        response: function () {
                            return verificationService.getNewVerificationDetails(
                                $scope.pageData[$index].id)
                                .success(function (verification) {
                                    verification.id = $scope.pageData[$index].id;
                                    verification.initialDate = $scope.pageData[$index].initialDate;
                                    return verification;
                                });
                        }
                    }
                });
            };

            $scope.idsOfVerifications = [];
            $scope.checkedItems = [];
            $scope.allIsEmpty = true;
            
            /**
             * push verification id to array
             */
            $scope.resolveVerificationId = function (id) {

                var index = $scope.idsOfVerifications.indexOf(id);
                if (index === -1) {
                    $scope.idsOfVerifications.push(id);
                    index = $scope.idsOfVerifications.indexOf(id);
                }

                if (!$scope.checkedItems[index]) {
                    $scope.idsOfVerifications.splice(index, 1, id);
                    $scope.checkedItems.splice(index, 1, true);
                } else {
                    $scope.idsOfVerifications.splice(index, 1);
                    $scope.checkedItems.splice(index, 1);
                }
                checkForEmpty();
            };


            $scope.openSendingModal = function () {
                if (!$scope.allIsEmpty) {
                    var modalInstance = $modal.open({
                        animation: true,
                        templateUrl: '/resources/app/verificator/views/modals/verification-sending.html',
                        controller: 'SendingModalController',
                        size: 'md',
                        resolve: {
                            response: function () {
                                return verificationService.getProviders()
                                    .success(function (providers) {
                                        return providers;
                                    });
                            }
                        }
                    });

                    //executes when modal closing
                    modalInstance.result.then(function (verificator) {
                        $log.info(verificator);

                        var dataToSend = {
                            idsOfVerifications: $scope.idsOfVerifications,
                            verificator: verificator
                        };

                        $log.info(dataToSend);

                        verificationService
                            .sendVerificationsToVerificator(dataToSend)
                            .success(function () {
                                $scope.onTableHandling();
                            });
                        $scope.idsOfVerifications = [];
                        $scope.checkedItems = [];
                    });
                } else {
                    $scope.isClicked = true;
                }
            };

            var checkForEmpty = function () {
                $scope.allIsEmpty = $scope.idsOfVerifications.length === 0;
            };
        }]);
