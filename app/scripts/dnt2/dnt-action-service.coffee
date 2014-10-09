angular.module('dnt.action.service', [
  'ui.router'
])
  .factory('ActionService', ['$rootScope', ($rootScope)->
    class ActionService
      constructor: (@options)->
        actionServiceInstance = this
        fn = ()->
          actionServiceInstance.options.watch.items
        hd = (items)->
          console.log items
        $rootScope.$watchCollection fn, hd
        console.log "watching: " + fn + " with " + hd
      perform: (callback, event)->
        alert('test')
        selected = ""
        callback(selected);
      getSelections: ->
        this.options.watch.items
        this.options.mapping(item)
      getWeight: (key)->
        $$("tr[selection-key=" +key+"]").attr("weight")

      @make = (options) ->
        console.log options
        return new ActionService(options)

  ])