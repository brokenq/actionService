angular.module 'table', [
  'table.detail'
  'dnt.action.directive'  # dependency to dnt.action.service module
]
  .config ($stateProvider)->
    $stateProvider.state 'table',
      url: '/table'
      templateUrl: 'app/partials/test/table.jade'

  #  inject into ActionService
  .controller 'tableCtrl', ['$scope', 'Phone', 'ngTableParams', 'ActionService', '$location', '$timeout', ($scope, Phone, ngTableParams, actionService, $location, $timeout)->
    options =
      page:  1          # show first page
      count: 10           # count per page
    args =
      total: 0
      getData: ($defer, params)->
        Phone.query(params.url(), (data, headers) ->
          $timeout(->
            params.total(headers('total'))
            $defer.resolve($scope.phones = data)
            $scope.getPhoneByAge  = ->
                param = $scope.actionService.getQueryData()
                return phone for phone in $scope.phones when phone.age is parseInt(param, 10)
            $scope.actionService = actionService.init({scope: $scope, datas: $scope.phones, checkKey: "age", mapping: $scope.getPhoneByAge})
            $scope.checkDatas = $scope.actionService.getCheckDatas()
          , 500)
        )
    $scope.tableParams = new ngTableParams(angular.extend(options, $location.search()), args)

#    Phone.query().$promise.then (phones)->
#      $scope.phones = phones
#      $scope.getPhoneByAge  = ->
#        param = $scope.ActionService.getQueryData()
#        return phone for phone in $scope.phones when phone.age is parseInt(param, 10)
#      $scope.ActionService = ActionService.init({scope: $scope, datas: $scope.phones, checkKey: "age", mapping: $scope.getPhoneByAge})
#      $scope.checkDatas = $scope.ActionService.getCheckDatas()

#      options =
#        page:  1          # show first page
#        count: 10           # count per page
#      args =
#        total: $scope.phones.length
#        getData: ($defer, params)->
#          $defer.resolve($scope.phones.slice((params.page() - 1) * params.count(), params.page() * params.count()))
#      $scope.tableParams = new ngTableParams(options, args)


    $scope.approve = ->
      alert 'approve'
    $scope.compare = ->
      alert 'compare'
    $scope.refresh = ->
      alert 'refresh'
      window.location.reload()
  ]