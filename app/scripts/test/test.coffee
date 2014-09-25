angular.module 'table', [
  'table.detail'
  'dnt.action.directive'  # dependency to dnt.action.service module
]
  .config ($stateProvider)->
    $stateProvider.state 'table',
      url: '/table'
      templateUrl: 'app/partials/test/table.jade'
#    $stateProvider.state 'table.detail',
#      url: '/detail'
#      templateUrl: 'app/partials/test/detail.jade'

  #  inject into ActionService
  .controller 'tableCtrl', ['$scope', 'Phone', 'ngTableParams', 'ActionService', '$filter', ($scope, Phone, ngTableParams, ActionService, $filter)->
    $scope.checkboxes = { 'checked': false, items: {}, elements: {}}
    $scope.ActionService = ActionService
    $scope.ActionService.setEval($scope)
  #    $scope.ActionService.bindSelection $scope.checkboxes.items
  #    $scope.test = 'testing'

    $scope.phones = Phone.query()
    options =
      page:  1          # show first page
      count: 10           # count per page
    args =
      total: $scope.phones.length
      getData: ($defer, params)->
        $defer.resolve($scope.phones.slice((params.page() - 1) * params.count(), params.page() * params.count()))
    $scope.tableParams = new ngTableParams(options, args)

#    $scope.$watch('checkboxes.items', (values) ->
##      $scope.$broadcast 'selectChanged', $scope.checkboxes
#      return if !$scope.phones
#      checked = 0
#      unchecked = 0
#      total = $scope.phones.length
#      angular.forEach $scope.phones, (item)->
#        checked   +=  ($scope.checkboxes.items[item.id]) || 0
#        unchecked += (!$scope.checkboxes.items[item.id]) || 0
#      $scope.checkboxes.checked = (checked == total) if (unchecked == 0) || (checked == 0)
#      angular.forEach angular.element($('[dnt-service] table :checked')).parent().parent(), (tr)-> # receive all of the tr that are chcked
#        angular.forEach values, (isSelected, key)-> # assign the value to the elements
#          if isSelected then $scope.checkboxes.elements[key] = tr else delete $scope.checkboxes.elements[key]
#    , true)

    $scope.approve = ()->
      alert('approve');
    $scope.compare = ()->
      alert('compare');
#    $scope.$eval 'test()'

#    $scope.$on '$viewContentLoaded', ()->
  ]