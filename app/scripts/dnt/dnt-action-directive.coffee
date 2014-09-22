angular.module 'dnt.action.directive', [
  'dnt.action.service'
]

	.directive 'dntService',['$filter', '$parse', ($filter, $parse)->
		link = (scope, element, attrs)->
      angular.element(document).ready ()->
        scope.service.bindSelection scope.data
        console.log scope.service.getSelectedDatas()
#        console.log attrs['dntBind']
#        scope.actionService = attrs['dntBind']
#        scope.actionService.bindSelection({name: 'user', age: 1})
#        console.log scope.actionService.getSelectedDatas()
		return {
			link: link
			scope:
        service: '=dntService'
        data: '=dntData'
			transclude: true
			template: '<div ng-transclude></div>'
		}
	]

#  .directive 'dntBind', ['$filter', '$parse', 'ActionService', ($filter, $parse, ActionService)->
#    link = (scope, element, attrs)->
#      scope.ActionService = ActionService
#      angular.element(document).ready ()->
#        splits = $.trim(attrs['dntBind']).split('.')
#        service = $.trim(splits[0])  # ActionService
#        splits = $.trim(splits[1]).split('as')
#        func = $.trim(splits[0]) # the function of ActionService
#        alias = $.trim(splits[1])  #alias of ActionService
#        console.log window['$scope.phones']
#      fn = $parse attrs['dntBind']
#      angular.element(document).ready (e)->
#        fn scope, {event: e}
#        console.log angular.element().find('dntBind')
#        console.log 'document.ready'
#    return {
#      link: link
#    }
#  ]

  .directive 'dntFire', ['$parse', ($parse)->
    link = (scope, element, attrs)->
      fn = $parse attrs['dntFire']
      element.on 'click', (e)->
        fn scope, {event: e}
    return {
      link: link
    }
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
#  .directive 'dntBind', ['ActionService', '$parse', '$filter', (ActionService, $parse, $filter)->
#    link = (scope, element, attrs)->
#      fn = $parse attrs['dntBind']
#      scope.$on 'actionServiceInit', (e)->
#        fn scope, {event: e}
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
#    return {
#      restrict: 'A'
#      transclude: true
#      scope: {}
#      template: '<div ng-transclude></div>'
#      link: link
#      controller: ctrl
#    }
#  ]

#  .directive 'dntWeighing', [()->
#    link = (scope, element, attrs)->
#    return {
#      restrict: 'A'
#      transclude: true
#      scope: {}
#      template: '<div ng-transclude></div>'
#      link: link
#    }
#  ]

#  .directive 'dntRequireCss', [()->
#    link = (scope, element, attrs)->
#    return {
#      restrict: 'A'
#      transclude: true
#      scope: {}
#      template: '<div ng-transclude></div>'
#      link: link
#    }
#  ]

#  .directive 'dntRejectCss', [()->
#    link = (scope, element, attrs)->
#    return {
#      restrict: 'A'
##      transclude: true
##      scope: {}
##      template: '<div ng-transclude></div>'
#      link: link
#    }
#  ]