angular.module 'table', [
  'table.detail'
  'dnt.action.directive'  # dependency to dnt.action.service module
]
  .config ($stateProvider)->
    $stateProvider.state 'table',
      url: '/table'
      templateUrl: 'app/partials/test/table.jade'

  #  inject into ActionService
  .controller 'tableCtrl', ['$scope', 'Phone', 'ngTableParams', 'ActionService', ($scope, Phone, ngTableParams, ActionService)->
    Phone.query().$promise.then (phones)->
      $scope.phones = phones
      $scope.getPhoneByAge  = ->
#        return phone for phone in $scope.phones when phone.age is parseInt(age, 10)
        param = $scope.ActionService.getMappingData()
        for phone in $scope.phones
          if phone.age is parseInt(param, 10)
            console.log phone
            return phone
      $scope.ActionService = ActionService.init({scope: $scope, datas: $scope.phones, mapping: $scope.getPhoneByAge})
      $scope.checkDatas = $scope.ActionService.getCheckDatas()

      options =
        page:  1          # show first page
        count: 10           # count per page
      args =
        total: $scope.phones.length
        getData: ($defer, params)->
          $defer.resolve($scope.phones.slice((params.page() - 1) * params.count(), params.page() * params.count()))
      $scope.tableParams = new ngTableParams(options, args)


    $scope.approve = ()->
      alert('approve');
    $scope.compare = ()->
      alert('compare');
    $scope.refresh = ()->
      alert('refresh');
  ]