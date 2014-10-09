angular.module('dnt.action.directive', [
  'dnt.action.service'
])
	.directive('dntAction',['$parse', ($parse)->
		return {
      restrict: 'A'
      link: (scope, element, attrs)->
        expr = attrs['dntAction']
        actionService = scope.$eval(expr)
        scope['actionService'] = actionService;
		}
	])
#  .directive('dntFire', ['$parse', ($parse)->
#    link = (scope, element, attrs)->
#      fn = $parse attrs['dntFire']
#      element.on 'click', (e)->
##        param =
##          weighing: attrs.weighing
##          rejectCss: attrs.rejectCss
##          requireCss: attrs.requireCss
##        scope.actionService.setAttributes(param)
#        fn scope, {event: e}
#    return {
#      link: link
#    }
#  ])