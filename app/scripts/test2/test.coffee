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
      alert 'approve'
    $scope.compare = (phone)->
      alert 'compare'
    $scope.refresh = ->
      alert 'refresh'
      window.location.reload()

    $scope.regx = /^((\d*[*])|(\d+[+]?)|\d+)$/
    console.log ":" + $scope.regx.test("")
    console.log "*:" + $scope.regx.test("*")
    console.log "+:" + $scope.regx.test("+")
    console.log "11:" + $scope.regx.test("11")
    console.log "11*:" + $scope.regx.test("11*")
    console.log "11+:" + $scope.regx.test("11+")
    console.log "11**:" + $scope.regx.test("11**")
    console.log "11++:" + $scope.regx.test("11++")
  ]