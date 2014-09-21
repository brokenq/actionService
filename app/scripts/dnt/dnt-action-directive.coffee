angular.module 'dnt.action.directive', [
  'dnt.action.service'
]

#  .directive 'dntTableAction', ['ActionService', '$filter', (ActionService, $filter)->
##    ctrl = ['$scope', 'ActionService', ($scope, ActionService)->
##      $scope.ActionService = ActionService
##    ]
#    link = (scope, element, attrs)->
#      scope.ActionService = ActionService
#      scope.aa = 'test'
#      element.button.on 'click', ()->
#        console.log($filter('json')(element))
#    return {
#      restrict: 'E'
#      transclude: true
#      scope: {}
#      template: '<div ng-transclude></div>'
#      link: link
##      controller: ctrl
#    }
#  ]
  #  bind to the table
  .directive 'dntBind', ['ActionService', '$parse', '$filter', (ActionService, $parse, $filter)->
    link = (scope, element, attrs)->
      fn = $parse attrs['dntBind']
      scope.$on 'actionServiceInit', (e)->
        fn scope, {event: e}
#      scope.bindVal = attrs.dntBind
#      console.log('bindVal:' +scope.bindVal)
#      scope.$on 'selectChanged', (event, args)->
#        ActionService.checkboxes = scope.checkboxes

#    ctrl = ['$scope', ($scope)->
#      @test = (args)->
#        alert(args)
#      @gotoState = (state)->
#        alert('s');
##        ActionService.gotoState state
#    ]
    return {
      restrict: 'A'
#      transclude: true
      scope: {}
#      template: '<div ng-transclude></div>'
      link: link
#      controller: ctrl
    }
  ]

  .directive 'dntWeighing', [()->
    link = (scope, element, attrs)->
    return {
      restrict: 'A'
#      transclude: true
#      scope: {}
#      template: '<div ng-transclude></div>'
      link: link
    }
  ]

  .directive 'dntRequireCss', [()->
    link = (scope, element, attrs)->
    return {
      restrict: 'A'
#      transclude: true
#      scope: {}
#      template: '<div ng-transclude></div>'
      link: link
    }
  ]

  .directive 'dntRejectCss', [()->
    link = (scope, element, attrs)->
    return {
      restrict: 'A'
#      transclude: true
#      scope: {}
#      template: '<div ng-transclude></div>'
      link: link
    }
  ]

  .directive 'dntFire', ['ActionService', (ActionService)->
    link = (scope, element, attrs, ctrl)->
#      ctrl.test('test')
#      element.on 'click', ()->
#        ctrl.gotoState('table.detail')
#        ActionService.gotoState 'table.detail'
    return {
#      require: '^dntBind'
      restrict: 'A'
      transclude: true
      scope: {}
      template: '<div ng-transclude></div>'
      link: link
    }
  ]

