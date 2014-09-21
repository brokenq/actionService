angular.module('main', [
  'ngTable'

  'direct'
  'table'
])
  .config ($stateProvider)->
#    $stateProvider.state 'table',
#      url: '/table'
#      templateUrl: 'app/partials/test/table.jade'
    $stateProvider.state 'test1',
      url: '/test1'
      templateUrl: 'app/partials/test1.jade'

  .controller('mainCtrl', ['$scope', '$location', 'ngTableParams', 'Phone', 'Action', ($scope, $location, ngTableParams, Phone, Action)->
    $scope.Action = Action
    $scope.foo = 0
    $scope.bar = 0
#    $scope.main = 'Main'
#    $scope.user =
#      name: 'brokenq',
#      phone: '13800138000'
#    $scope.animal =
#      name: 'mk',
#      kind: 'monkey',
#      eat: 'pink'
#    $scope.animals = [{
#      name: 'pad',
#      kind: 'panda'
#    },{
#      name: 'at',
#      kind: 'ant'
#    }]
#    $scope.dateFormat = 'M/d/yy h:mm:ss a'
  ])


