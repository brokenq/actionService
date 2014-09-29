'use strict'

### App Module ###

phonecatApp = angular.module('phonecatApp', [
  'ngRoute'
  'ui.router'
  'phonecatControllers'
  'phonecatFilters'
  'phonecatServices'
  'app.templates'
  'main'
])

#phonecatApp.config ($stateProvider, $urlRouterProvider)->
#  $stateProvider.state 'main',
#    url: '/main'
#    templateUrl: 'app/partials/main.jade'
#  $stateProvider.state 'phones',
#    url: '/phones'
#    templateUrl: 'app/partials/phone-list.jade'
#  $stateProvider.state 'phones.detail',
#    url: '/phones/:phoneId'
#    templateUrl: 'app/partials/phone-detail.jade'
#  $urlRouterProvider.otherwise('main')
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
