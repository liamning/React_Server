/**
 * INSPINIA - Responsive Admin Theme
 *
 */
(function () {
    agGrid.initialiseAgGridWithAngular1(angular);
    angular.module('inspinia', [
        'ui.router',                    // Routing
        'oc.lazyLoad',                  // ocLazyLoad
        'ui.bootstrap',                 // Ui Bootstrap
        'ui.select',
        'ngSanitize',
        'duScroll',
        'ngMaterial',
        'agGrid',
    ])


    $(window).keydown(function (e) { if (e.keyCode == 32) debugger; });
})();

