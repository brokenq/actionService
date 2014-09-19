angular.module('main', [

])
  .config ($stateProvider)->
    $stateProvider.state 'test1',
        url: '/test1',
        templateUrl: 'app/partials/test1.jade'

  .controller('mainCtrl', ['$scope', ($scope)->
    $scope.main = 'Main'
  ]);