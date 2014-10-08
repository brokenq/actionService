angular.module('dnt.action.directive', [
  'dnt.action.service'
])
	.directive('dntAction',[->
		return {
			scope:
        action: '=dntAction'
			transclude: true
			template: '<div ng-transclude></div>'
		}
	])
#  .directive('dntFire', ['$parse', ($parse)->
#    link = (scope, element, attrs)->
#      fn = $parse attrs['dntFire']
#      element.on 'click', (e)->
#        param =
#          weighing: attrs.weighing
#          rejectCss: attrs.rejectCss
#          requireCss: attrs.requireCss
#        scope.actionService.setAttributes(param)
#        fn scope, {event: e}
#    return {
#      link: link
#    }
#  ])