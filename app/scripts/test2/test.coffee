angular.module 'table', [
  'table.detail'
  'dnt.action.directive'  # dependency to dnt.action.service module
]
  .config ($stateProvider)->
    $stateProvider.state 'table',
      url: '/table'
      templateUrl: 'app/partials/test2/table.jade'

  #  inject into ActionService
  .controller 'tableCtrl', ['$scope', 'Phone', 'ngTableParams', 'ActionService', '$location', '$timeout', ($scope, Phone, ngTableParams, ActionService, $location, $timeout)->
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
          , 500)
        )
    $scope.tableParams = new ngTableParams(angular.extend(options, $location.search()), args)

    $scope.selection = {checked: false, items: {}}

    $scope.getPhoneByAge  = (age)->
      param = $scope.actionService.getQueryData()
      return phone for phone in $scope.phones when phone.age is parseInt(param, 10)

    $scope.actionService = new ActionService({watch: $scope.selection, mapping: $scope.getPhoneByAge})

    $scope.approve = (phone)->
      alert 'approve'
    $scope.compare = (phone)->
      alert 'compare'
    $scope.refresh = ->
      alert 'refresh'
      window.location.reload()
  ]