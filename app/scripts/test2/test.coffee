angular.module 'table', [
  'table.detail'
  'dnt.action.service'
]
  .config ($stateProvider)->
    $stateProvider.state 'table',
      url: '/table'
      templateUrl: 'app/partials/test2/table.jade'

  #  inject into ActionService
  .controller 'tableCtrl', ['$scope', 'Phone', 'ngTableParams', 'ActionService', '$location', '$timeout', '$filter', ($scope, Phone, ngTableParams, ActionService, $location, $timeout, $filter)->
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
      return phone for phone in $scope.phones when phone.age is parseInt(age, 10)
    $scope.actionService = new ActionService({watch: $scope.selection, mapping: $scope.getPhoneByAge})

    $scope.$watch 'selection.checked', (value)->
      angular.forEach $scope.phones, (item)->
        $scope.selection.items[item.age] = value if angular.isDefined(item.age)
    # watch for data checkboxes
    $scope.$watch('selection.items', (values) ->
      return if !$scope.phones
      checked = 0
      unchecked = 0
      total = $scope.phones.length
      angular.forEach $scope.phones, (item)->
        checked   +=  ($scope.selection.items[item.age]) || 0
        unchecked += (!$scope.selection.items[item.age]) || 0
      $scope.selection.checked = (checked == total) if (unchecked == 0) || (checked == 0)
      # grayed checkbox
      angular.element(document.getElementById("select_all")).prop("indeterminate", (checked != 0 && unchecked != 0));
    , true)

    $scope.approve = (phone)->
      alert "approve: #{$filter('json')(phone)}"
    $scope.reject = (phone)->
      alert "reject: #{$filter('json')(phone)}"
    $scope.compare = (phone1, phone2)->
      alert "compare: \n phone1: #{$filter('json')(phone1)} \n phone2: #{$filter('json')(phone2)}"
    $scope.refresh = ->
      alert "refresh"
    $scope.testWeight = (phones)->
      alert "testWeight: #{$filter('json')(phones)}"

#    String.prototype.supplant =  (o) ->
#      this.replace /{([^{}]*)}/g, (a, b)->
#        r = o[b]
#        if typeof r is 'string' or typeof r is 'number' then r else a
#    alert("I'm {0} years old!".supplant(29 ))
  ]