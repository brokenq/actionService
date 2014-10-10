angular.module('dnt.action.service', [
  'ui.router'
])
  .factory('ActionService', ['$rootScope', '$state', ($rootScope, $state)->
    class ActionService
      CODE:
        DNT_KEY: "dnt-key"
      CSS:
        WEIGHING: "weighing"
        REJECT_CSS: "reject-css"
        REQUIRE_CSS: "require-css"
      INFO:
        REJECT: "you must select {0} records to perform this action"
        REJECT_AT_LEAST: "you must select {0} records to perform this action at least"
        CHECK_STATUS: "you can't perform this action, please check the status of records which were selected"

      constructor: (@options)->

      ### @function: before | deal with the conditions before perform the action
          @param: event | event
          @return: the selected datas###
      before: (event)->
        conditions = @getConditions event
        selections = @getSelections()
        if @isConditionPass conditions, selections then return selections.datas else return null

      ### @function: gotoState | redirect to another page
          @param: state | state of the page you want to redirect
          @param: event | event
          @return: void###
      gotoState: (state, event)->
        datas = @before event
        $state.go state, datas[0] if datas?

      ### @function: perform | perform the callback function
          @param: callback | the function you want to perform
          @param: event | event
          @return: void###
      perform: (callback, event)->
        datas = @before event
        callback datas if datas?

      ### @function: isConditionPass | you can perform the action if the conditon is passed
          @param: conditions | button attributes: weighing, reject-css, require-css
          @param: selections | contains the selected datas and elements of tr
          @return: true|false | true: passed; false: not pass###
      isConditionPass: (conditions, selections)->
        if /^\d+$/.test conditions.weighing
          weighing = parseInt conditions.weighing
          if weighing is selections.datas.length then return @checkStatus(conditions, selections) else alert @stringFormat @INFO.REJECT, "#{weighing}"

        if /^\d+[+]$/.test conditions.weighing
          min = parseInt conditions.weighing.split(/[+]/)[0]
          if selections.datas.length >= min then return @checkStatus(conditions, selections) else alert @stringFormat @INFO.REJECT_AT_LEAST, "#{min}"

        if /^[*]$/.test conditions.weighing then return @checkStatus(conditions, selections)
        return false

      ### @function: checkStatus | used in isConditionPass function
          @param: conditions | button attributes: weighing, reject-css, require-css
          @param: selections | contains the selected datas and elements of tr
          @return: true|false | true: passed; false: not pass###
      checkStatus: (conditions, selections)->
        return true if @isCssPass conditions, selections
        alert @INFO.CHECK_STATUS
        return false

      ### @function: isCssPass | were css passed
          @param: conditions | button attributes: weighing, reject-css, require-css
          @param: selections | contains the selected datas and elements of tr
          @return: true|false | true: passed; false: not pass###
      isCssPass: (conditions, selections)->
        rejectCssJson = @getCss(conditions.rejectCss)
        requireCssJson = @getCss(conditions.requireCss)
        return false if @isReject(rejectCssJson, selections.trs)
        return @isRequire(requireCssJson, selections.trs)

      ### @function: isReject | were reject-css passed
          @param: rejectCssJson | reject-css
          @param: trs | selected elements of tr
          @return: true|false | true: rejected; false: passed###
      isReject: (rejectCssJson, trs)->
        for tr in trs
          trCssJson = @getClass(tr)
          return true for rejectCss of rejectCssJson when trCssJson[rejectCss]?
        return false

      ### @function: isRequire | were require-css passed
          @param: requireCssJson | require-css
          @param: trs | selected elements of tr
          @return: true|false | true: passed; false: not pass###
      isRequire: (requireCssJson, trs)->
        for tr in trs
          trCssJson = @getClass(tr)
          return false for requireCss of requireCssJson when !trCssJson[requireCss]?
        return true

      ### @function: getConditions | get button attributes: weighing, reject-css, require-css
          @param: event | event-css
          @return: conditions###
      getConditions: (event)->
        element = $(event.srcElement)
        conditions =
          weighing: element.attr(@CSS.WEIGHING)
          rejectCss: element.attr(@CSS.REJECT_CSS)
          requireCss: element.attr(@CSS.REQUIRE_CSS)
        return conditions

      ### @function: getSelections | get selected datas and elements of tr
          @return: selections###
      getSelections: ->
        selections = {datas: [], trs: []}
        for key, val of @options.watch.items when val
          selections.datas.push @options.mapping(key)
          selections.trs.push $("[#{@CODE.DNT_KEY}=#{key}]")
        return selections

      ### @function: getCss | get css
          @param: classes | class of elements
          @return: json datas of css###
      getCss: (classes)->
        cssJson = {}
        if classes? then cssJson[css] = css for css in classes.split(/\s+/)
        return cssJson

      ### @function: getClass | get css of which selected elements of tr
          @param: tr | elements of tr
          @return: json datas of css###
      getClass: (tr)->
        return @getCss($(tr).attr("class"))

      ### @function: stringFormat | format the string
          @demo: stringFormat("i have {0} {1}", "two", "apples")
                 print: i have two apples
          @return: format string###
      stringFormat: ->
        return null if arguments.length is 0
        string = arguments[0]
        for val, i in arguments when i isnt 0
          regx = new RegExp '\\{' + (i - 1) + '\\}', 'gm'
          string = string.replace regx, val
        return string

      ### @function: @make | instance a new ActionService
          @param: options | init params
          @return: instance of ActionService###
      @make = (options) ->
        return new ActionService(options)

  ])