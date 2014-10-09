angular.module('dnt.action.service', [
  'ui.router'
])
  .factory('ActionService', ['$rootScope', ($rootScope)->
    class ActionService
      constructor: (@options)->
#        instance = this
#        fn = ()->
#          instance.options.watch.items
#        hd = (items)->
#          console.log items
#        $rootScope.$watchCollection fn, hd
#        $rootScope.$watch instance.options.watch.checked, ->
#
#        console.log "watching: " + fn + " with " + hd

      gotoState: (state, event)->
        conditions = @getConditions(event)
        selections = @getSelections()

      perform: (callback, event)->
        selected = ""
        callback(selected)

      getConditions: (event)->
        element = $(event.srcElement)
        conditions =
          weighing: element.attr("weighing")
          rejectCss: element.attr("reject-css")
          requireCss: element.attr("require-css")
        return conditions

      getSelections: ->
        selections = {datas: [], trs: []}
        for key, val of @options.watch.items
          if val
            selections.datas.push @options.mapping(key)
            selections.trs.push $("[dnt-key=#{key}]")

      getWeight: (key)->
        $$("tr[selection-key=" +key+"]").attr("weight")

      @make = (options) ->
        console.log options
        return new ActionService(options)

  ])