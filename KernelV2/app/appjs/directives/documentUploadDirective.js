angular.module('attuneKernel.directives')
.directive('documentUploadDirective', ['DataFactory', '$compile', '$rootScope',
		function (DataFactory, $compile, $rootScope) {
		    return {
		        controller: function ($scope) {
		            $scope.txtFileType = "";
		            $scope.uploadfile = "";

		            $scope.getMetaData = function (Name, Domain) {
		                return DataFactory.get('metadata', {		                    
		                    Domain: Domain
		                }, false).then(function (response) {
		                    return response.data.map(function (item) {
		                        return item;
		                    });
		                });
		            };

		            $scope.addDocuments = function () {
		                
		                if ($scope.uploadfile != "") {
		                    var obj = new Object();
		                    obj.FileType = $scope.txtFileType;
		                    obj.File = {};
		                    obj.File.File = new Object($scope.uploadfile);
		                    obj.File.Name = $scope.uploadfile.name;
		                    obj.File.Type = $scope.uploadfile.type;
		                    obj.File.FilePath = 'File:' + $scope.uploadfile.name;
		                    handleFileSelect(obj.File);
		                    if ($scope.lstDocuments == undefined || $scope.lstDocuments == null) {
		                        $scope.lstDocuments = [];
		                    }
		                    $scope.lstDocuments.push(obj);
		                }
		                $scope.clearFiles();
		            }
		            $scope.deleteFiles = function (id) {
		                $scope.lstDocuments.splice(id, 1);
		            }

		            var handleFileSelect = function (evt) {
		                if (evt != undefined) {
		                    var file = evt.File;
		                    var reader = new FileReader();
		                    reader.onload = function (e) {
		                        $scope.$apply(function ($scope) {
		                            evt.Image = e.target.result;
		                            //alert('File 1' + $scope.myImage);
		                            //  $scope.isUpload = 'File';
		                            // $scope.blob = dataURItoBlob($scope.myImage);
		                        });
		                    };
		                    reader.readAsDataURL(file);
		                }
		            };

		            $scope.clearFiles = function () {
		                $scope.txtFileType = "";
		                $scope.uploadfile = "";
		            }
		            $scope.chkDuplicate = function () {
		                if ($scope.lstDocuments != undefined && $scope.lstDocuments.length > 0) {
		                    for (i = 0; i < $scope.lstDocuments.length; i++) {
		                        if ($scope.lstDocuments[i].FileType == $scope.txtFileType) {
		                            alert("File Type Already Exists !");
		                            $scope.clearFiles();
		                            return false;
		                        }
		                    }
		                }
		            }

		        },
		        templateUrl: '../KernelV2/app/template/directives/documentUpload.html',
		        link: function (scope, elem, attrs) {
		            if ($rootScope.ViewParts != undefined) {
		                var pageData = Enumerable.From($rootScope.ViewParts).Where(function (x) {
		                    return x.RefID == 5
		                }).Select(function (x) {
		                    return x.Html
		                }).FirstOrDefault();
		                var compiled = $compile(pageData)(scope);
		                var box = "#dynContent";
		                angular.element(box).append(compiled);
		            }
		        },
		        restrict: 'AE',
		        scope: {
		            lstDocuments: '=lstdocument'
		        }
		    };

		}
])
.directive('fileModel', ['$parse', function ($parse) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;

            element.bind('change', function () {
                scope.$apply(function () {
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
}
]);
