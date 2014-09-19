angular.module('main', [])
  .controller('mainCtrl', ['$scope', ($scope)->
    $scope.main = 'Main'
  ]);