angular.module('main', [

])
  .config ($stateProvider)->
    $stateProvider.state 'test1',
        url: '/test1',
        templateUrl: 'app/partials/test1.jade'

  .controller('mainCtrl', ['$scope', ($scope)->
    $scope.main = 'Main'
    $scope.user =
      name: 'brokenq',
      phone: '13800138000'
    $scope.animal =
      name: 'mk',
      kind: 'monkey',
      eat: 'pink'
    $scope.animals = [{
      name: 'pad',
      kind: 'panda'
    },{
      name: 'at',
      kind: 'ant'
    }]
    $scope.dateFormat = 'M/d/yy h:mm:ss a'
  ])

  .directive('myTest1', ()->
    return {
      restrict: 'E'
      template: '<h2>{{main}}</h2>'
    }
  )

  .directive('myTest1a', ()->
    return {templateUrl: 'app/partials/test1a.jade'}
  )

  .directive 'myTest1b', ()->
    return {
      scope:
        myTestScope: '=mytestscope'
      restrict: 'E'
      templateUrl: 'app/partials/test1b.jade'
    }

  .directive 'showTime', ['$interval', 'dateFilter', ($interval, dateFilter)->
    link = (scope, element, attrs) ->
      updateTime = ()->
        element.text(dateFilter(new Date(), 'M/d/yy h:mm:ss a'))
      timeOutId = $interval(()->
        updateTime()
      , 1000)
      element.on('$destroy', ()->
        $interval.cancel(timeOutId)
      )
      scope.$watch(attrs.showTime, (value) ->
#				format = value
      	updateTime()
      )
    return {link: link}
  ]