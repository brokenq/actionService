angular.module('direct', [])
#  .directive('myTest1', ()->
#    return {
#    restrict: 'E'
#    template: '<h2>{{main}}</h2>'
#    }
#  )

#  .directive('myTest1a', ()->
#    return {templateUrl: 'app/partials/test1a.jade'}
#  )
#
#  .directive 'myTest1b', ()->
#    return {
#    scope:
#      myTestScope: '=mytestscope' #＝绑定属性&绑定函数
#    restrict: 'E'
#    templateUrl: 'app/partials/test1b.jade'
#    }
#
#  .directive 'showTime', ($interval, dateFilter)->
#    link = (scope, element, attrs) ->
#      fmt = ''
#
#      updateTimes = ()->
#        element.text(dateFilter(new Date(), fmt))
#
#      timeOutId = $interval(()->
#        updateTimes()
#      , 1000)
#
#      element.on '$destroy', ()->
#        $interval.cancel(timeOutId)
#
#      scope.$watch attrs.showTime, (value)->
#        fmt = value
#        updateTimes()
#
#    return {link: link}
#
#  .directive 'myDialog', ()->
#    ctrl = ()->
#      this.test = (content)->
#        alert(content)
#    return {
#      restrict: 'E'
#      scope: {}
#      transclude: true
#      replace: false
#      templateUrl: 'app/partials/myDialog.jade'
##      link: (scope, element)->
##        scope.inner = 'inner'
#      controller: ctrl
#    }

  .factory 'Action', ()->
    test = (content)->
      alert(content)
    return {
      test: test
    }

  .directive 'ngClickTest', ($parse)->
    return {
#      scope: {}
      link: (scope, element, attrs)->
        fn = $parse attrs['ngClickTest']
        element.on 'click', (e)->
          fn scope, {event: e}
#        console.log(scope)
#        console.log(element)
#        console.log(attrs)
    }

  .directive 'clickable', ()->
    return {
      restrict: "E"
      scope:
        foo: '=',
        bar: '='
      template: '<ul style="background-color: lightblue"><li>{{foo}}</li><li>{{bar}}</li></ul>'
      link: (scope, element, attrs)->
        element.bind 'click', ()->
          scope.foo++
          scope.bar++
#          scope.$apply()
#          console.log(scope.foo + "======" + scope.bar)
    }

  .directive 'myD', ()->
    return {
      restrict: 'A'
      transclude: true
      scope: {}
      controller: ()->
        this.test = (content)->
          alert(content)
      template: '<div ng-transclude></div>'
    }

  .directive 'myDep', ()->
    return {
      restrict: 'A'
      require: '^myD'
      transclude: true
      scope: {}
#      template: '<div ng-transclude></div>'
      link: (scope, element, attrs, ctrl)->
        console.log(eval(ctrl))
        ctrl.test('test')
    }
#
#  .directive 'myTabs', ()->
#    return {
#      restrict: 'E'
#      transclude: true
#      scope: {}
#      controller: ($scope) ->
#        panes = $scope.panes = []
#
#        $scope.select = (pane)->
#          angular.forEach panes, (pane) ->
#            pane.selected = false
#          pane.selected = true
#
#        this.addPane = (pane) ->
#          $scope.select(pane) if panes.length == 0
#          panes.push(pane)
#      templateUrl: 'app/partials/my-tabs.jade'
#    }
#  .directive 'myPane', () ->
#    return {
#      require: '^myTabs'
#      restrict: 'E'
#      transclude: true
#      scope:
#        title: '@'
#      link: (scope, element, attrs, tabsCtrl) ->
#        tabsCtrl.addPane(scope)
#      templateUrl: 'app/partials/my-panes.jade'
#    }
