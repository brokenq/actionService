angular.module 'table.detail', []
  .config ['$stateProvider', ($stateProvider)->
    $stateProvider.state 'table.detail',
      url: '/detail/{age}'
      templateUrl: 'app/partials/test2/detail.jade'
  ]

  .controller 'tableDetailCtrl', ['$scope', '$stateParams', ($scope, $stateParams)->
    $scope.age = $stateParams.age
  ]