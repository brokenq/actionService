angular.module 'table.detail', []
  .config ['$stateProvider', ($stateProvider)->
    $stateProvider.state 'table.detail',
      url: '/detail/{id}'
      templateUrl: 'app/partials/test/detail.jade'
  ]

  .controller 'tableDetailCtrl', ['$scope', '$stateParams', ($scope, $stateParams)->
    $scope.id = $stateParams.id
  ]