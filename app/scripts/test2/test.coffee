angular.module 'table', [
  'table.detail'
  'dnt.action.directive'  # dependency to dnt.action.service module
]
  .config ($stateProvider)->
    $stateProvider.state 'table',
      url: '/table'
      templateUrl: 'app/partials/test2/table.jade'

  #  inject into ActionService
  .controller 'tableCtrl', ['$scope', 'Phone', 'ngTableParams', 'ActionService', '$location', '$timeout', ($scope, Phone, ngTableParams, actionService, $location, $timeout)->
    $scope.selection = {checked: false, items: {}}
    $scope.actionService = actionService
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
          , 500)
        )
    $scope.tableParams = new ngTableParams(angular.extend(options, $location.search()), args)


    $scope.approve = ->
      alert 'approve'
    $scope.compare = ->
      alert 'compare'
    $scope.refresh = ->
      alert 'refresh'
      window.location.reload()
  ]