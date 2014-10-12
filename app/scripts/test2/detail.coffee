angular.module 'table.detail', []
  .config ['$stateProvider', ($stateProvider)->
    $stateProvider.state 'table.detail',
      url: '/detail/{id}/{type}'
      templateUrl: 'app/partials/test2/detail.jade'
  ]

  .controller 'tableDetailCtrl', ['$scope', '$stateParams', ($scope, $stateParams)->
    $scope.id = $stateParams.id
    $scope.type = $stateParams.type
  ]