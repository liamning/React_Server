/**
 * INSPINIA - Responsive Admin Theme
 *
 */

/**
 * MainCtrl - controller
 */
function MainCtrl($scope, $state, $http) {

    $scope.loginID = "Administrator";

    $scope.refresh_ui_select_list = {};
    $scope.refresh_ui_select = function (table, input, limit, includeInput, callback) {
        if (limit && (!input || input.length < limit)) return;
        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({ action: "refreshList", Table: table, Input: input }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {

            console.log('refresh_ui_select [' + table + '] [Done].');

            if (response) {
                $scope.refresh_ui_select_list[table] = response;
                if (response && input && includeInput)
                    response.unshift({
                        'Code': input,
                        'Desc': input,
                    });
            }
            if (callback)
                callback(response);
        });

    }
    $scope.ui_select_change = function (table) {
        $scope.refresh_ui_select_list[table].length = 0;
    }


    $scope.generalMaster = {};
    $scope.getGeneralMasterList = function (categories, callback) {
        var index;
        for (var pro in $scope.generalMaster) {
            index = categories.indexOf(pro);
            if (index < 0) {
                $scope.generalMaster[pro].length = 0;
            } else {
                categories.splice(index, 1);
            }
        }

        if (categories.length == 0) return;

        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({ action: "getGeneralMasterList", categories: JSON.stringify(categories) }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {
            if (response) {

                for (pro in response)
                    $scope.generalMaster[pro] = response[pro];

                console.log($scope.generalMaster);
            }

            if (callback)
                callback(response);
        });
    }


};


function SampleCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.sampleObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "Sample",
            url: 'views/sampleHeader.html',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        $scope.getGeneralMasterList(["Relationship"]);

    })();

    //event 
    $scope.addChild = function () {
        if (!$scope.sampleObj.ChildList)
            $scope.sampleObj.ChildList = [];
        $scope.sampleObj.ChildList.push({
        });

    }

    $scope.editChild = function (child) {

        $scope.currentChild = child;

        $scope.templateURL.name = 'Child Details';
        $scope.templateURL.url = 'views/sampleChild.html';

        $scope.templateURL.pageNo++;
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };


    }

    $scope.removeChild = function (child) {
        for (var i = 0; i < $scope.sampleObj.ChildList.length; i++) {
            var obj = $scope.sampleObj.ChildList[i];

            if (obj.ID == child.ID) {
                $scope.sampleObj.ChildList.splice(i, 1);
            }
        }

    }

    $scope.save = function () {

        if ($scope.userForm.$invalid) return;

        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({
                action: "saveSample",
                SampleInfo: JSON.stringify($scope.sampleObj)
            }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {

            alert(response.message);
            console.log("success");

        });

    };

    $scope.delete = function () {

        if (!$scope.sampleObj.ClientNo) return;

        $.ajax({
            url: "/HttpHandler/AjaxHandler.ashx",
            type: 'POST',
            data: {
                action: "deleteSample",
                ClientNo: $scope.sampleObj.ClientNo
            },
            dataType: "json",
            error: function (xhr) {
                console.log("failed");
            },
            success: function (response) {
                alert(response.message);
                console.log("success");
            }
        });
    };

    $scope.sampleIDChange = function () {
        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({ action: "getSample", SampleNo: $scope.sampleObj.SampleNo }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {
            console.log(response);
            if (response)
                $scope.sampleObj = response;
            else {
                confirm("Confirm to Create a new record?")
                $scope.sampleObj = {
                    SampleNo: $scope.sampleObj.SampleNo,
                };
            }

            console.log($scope.sampleObj);

        });

    }

}


function SampleChildCtrl($scope, $http, $window) {


    $scope.confirm = function () {

        $scope.viewsList.splice($scope.templateURL.pageNo, 1);

        $scope.templateURL.pageNo--;
        var currentView = $scope.viewsList[$scope.templateURL.pageNo];

        $scope.templateURL.name = currentView.name;
        $scope.templateURL.url = currentView.url;

    };

    $scope.cancel = function () {

        $scope.viewsList.splice($scope.templateURL.pageNo, 1);

        $scope.templateURL.pageNo--;
        var currentView = $scope.viewsList[$scope.templateURL.pageNo];

        $scope.templateURL.name = currentView.name;
        $scope.templateURL.url = currentView.url;

    };
}

function agGridTestCtrl ($scope) {

    var columnDefs = [
        { headerName: "Make", field: "make" },
        { headerName: "Model", field: "model" },
        { headerName: "Price", field: "price" }
    ];

    var rowData = [
        { make: "Toyota", model: "Celica", price: 35000 },
        { make: "Ford", model: "Mondeo", price: 32000 },
        { make: "Porsche", model: "Boxter", price: 72000 }
    ];

    $scope.gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData
    };

}

function testCtrl($timeout) {

    // In this example, we set up our model using a class.
    // Using a plain object works too. All that matters
    // is that we implement getItemAtIndex and getLength.
    var DynamicItems = function () {
        /**
         * @type {!Object<?Array>} Data pages, keyed by page number (0-index).
         */
        this.loadedPages = {};

        /** @type {number} Total number of items. */
        this.numItems = 0;

        /** @const {number} Number of items to fetch per request. */
        this.PAGE_SIZE = 50;

        this.fetchNumItems_();
    };

    // Required.
    DynamicItems.prototype.getItemAtIndex = function (index) {
        var pageNumber = Math.floor(index / this.PAGE_SIZE);
        var page = this.loadedPages[pageNumber];

        if (page) {
            return page[index % this.PAGE_SIZE];
        } else if (page !== null) {
            this.fetchPage_(pageNumber);
        }
    };

    // Required.
    DynamicItems.prototype.getLength = function () {
        return this.numItems;
    };

    DynamicItems.prototype.fetchPage_ = function (pageNumber) {
        // Set the page to null so we know it is already being fetched.
        this.loadedPages[pageNumber] = null;

        // For demo purposes, we simulate loading more items with a timed
        // promise. In real code, this function would likely contain an
        // $http request.
        $timeout(angular.noop, 300).then(angular.bind(this, function () {
            this.loadedPages[pageNumber] = [];
            var pageOffset = pageNumber * this.PAGE_SIZE;
            for (var i = pageOffset; i < pageOffset + this.PAGE_SIZE; i++) {
                this.loadedPages[pageNumber].push(i);
            }
        }));
    };

    DynamicItems.prototype.fetchNumItems_ = function () {
        // For demo purposes, we simulate loading the item count with a timed
        // promise. In real code, this function would likely contain an
        // $http request.
        $timeout(angular.noop, 300).then(angular.bind(this, function () {
            this.numItems = 50000;
        }));
    };

    this.dynamicItems = new DynamicItems();
}


angular
    .module('inspinia')
    .controller('MainCtrl', MainCtrl)
    .controller('SampleCtrl', SampleCtrl)
    .controller('SampleChildCtrl', SampleChildCtrl)
    .controller('testCtrl', testCtrl)
    .controller('agGridTestCtrl', agGridTestCtrl)