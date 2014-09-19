'use strict'

### App Module ###

phonecatApp = angular.module('phonecatApp', [
  'ngRoute'
  'phonecatControllers'
  'phonecatFilters'
  'phonecatServices'
  'app.templates'
  'main'
])

phonecatApp.config(['$routeProvider',
  ($routeProvider) ->
    $routeProvider.when(
        '/phones', {
          templateUrl: 'app/partials/phone-list.jade'
          controller: 'PhoneListCtrl'}).when(
        '/phones/:phoneId', {
          templateUrl: 'app/partials/phone-detail.jade'
          controller: 'PhoneDetailCtrl'
      }).when('/main',{
        templateUrl: 'app/partials/main.jade',
        controller: 'mainCtrl'
      }).otherwise({
#        redirectTo: '/phones'
        redirectTo: '/main'
      })
  ])
