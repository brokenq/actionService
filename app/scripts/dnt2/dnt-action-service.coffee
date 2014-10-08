angular.module('dnt.action.service', [
  'ui.router'
])
  .factory('ActionService', ['$state', ($state)->
    options =
      selection: null
      mapping: null
      datas: null
      scope: null




#    options =
#      scope: null # required | assign the $scope of Controller to this
#      datas: null # required | the datas of the table
#      checkKey: null # required |
#      checkModel: 'checkDatas' # not required; default is 'checkDatas' | if you don't specify the checkModel, it'll use the default value, or it'll use the value you specified
#      mapping: null # alternative | mapping function: get the object by object's field value
#      checkDatas: {'checked': false, items: {}, elements: {}} # not required | the checked datas
#      attributes: null # not required | the attributes of the button which you click
#      queryData: null # not required
#      tableId: '#table' # alternative | bing to the table

#    CSS =
#      WEIGHING: 'weighing'
#      REQUIRE_CSS: 'requireCss'
#      REJECT_CSS: 'rejectCss'
#    INFO =
#      NO_SELECTED: "you don't select any record"
#      REJECT_ONE: "this record can't be perform in this action, please check the status"
#      REJECT_TWO: "the two records can't be perform in this action, please check the status"
#      REJECT_MULTIPLE: "these records can't be perform in this action, please check the status"
#      ONLY_ONE: "you can only select one record to perform this action"
#      ONLY_TWO: "you must select two records to perform this action"
#      ONE_AT_LEAST: "you must select one record at least to perform this action"
#
#    ### @function: init | initialize the ActionService
#        @param: optionsParam | an json object which keys contains a part of keys of options
#        @return: void ###
    init = (optionsParam)->
      options.selection = optionsParam.selection if optionsParam.selection?
      options.mapping = optionsParam.mapping if optionsParam.mapping?
      options.datas = optionsParam.datas if optionsParam.datas?
      options.scope = optionsParam.scope if optionsParam.scope?
      console.log options.datas
#      watchAllSelect()
#      watchSingleSelect()
      return this
#
#    ### @function: gotoState | redirect to the state page
#        @param: state
#        @return: void ###
#    gotoState = (state)->
#      condition = isConditionPass()
#      if condition.passed
#        options.queryData = condition.datas[0]
#        $state.go state, options.scope.$eval(options.mapping)
#
#    ### @function: perform | redirect to the state page
#        @param: callback | the callback function
#        @return: void ###
#    perform = (callback)->
#      condition = isConditionPass()
#      options.scope.$eval(callback) if condition.passed
#
#    ### @function: refresh | refresh the page
#        @return: void ###
#    refresh = ()->
#      condition = isConditionPass()
#      window.location.reload() if condition.passed
#
    ### @function: watchAllSelect | watch all select
        @return: void ###
    watchAllSelect = ->
      options.scope.$watch "#{options.selection}.checked", (value) -> # if value is true, all of the table rows are selected, or none is selected
        angular.forEach options.datas, (item) ->
          options.selection.items[item[options.checkKey]] = value if angular.isDefined(item[options.checkKey])
        for checkbox in $(options.tableId + " tbody [type=checkbox]")
            if value then $(checkbox).attr(checked: 'checked') else $(checkbox).removeAttr('checked')
#
#    ### @function: watchSingleSelect | watch single select
#        @return: void ###
#    watchSingleSelect = ->
#      options.scope.$watch "#{options.checkModel}.items", ->
#        return if !options.datas
#        checked = 0
#        unchecked = 0
#        total = options.datas.length
#        angular.forEach options.datas, (item)->
#          checked   +=  (options.checkDatas.items[item[options.checkKey]]) || 0
#          unchecked += (!options.checkDatas.items[item[options.checkKey]]) || 0
#        options.checkDatas.checked = (checked == total) if (unchecked == 0) || (checked == 0)
#
#        updateElements()
#        angular.element(document.getElementById("select_all")).prop("indeterminate", (checked != 0 && unchecked != 0))
#      , true
#
#    ### @function: updateElements | update the selected elements
#        @return: void ###
#    updateElements = ->
#      selectedKeys = []
#      selectedKeys.push key for key, isSelected of options.checkDatas.items when isSelected
#      options.checkDatas.elements = {}
#      if options.checkDatas.checked
#        options.checkDatas.elements[selectedKeys[index]] = tr for tr, index in $(options.tableId + ' tbody [checked=checked]').parent().parent()
#      else
#        options.checkDatas.elements[selectedKeys[index]] = tr for tr, index in $(options.tableId + ' tbody :checked').parent().parent()
#
#    ### @function: isPass | prerequisite which you can perform the action
#        @return: an json object; passed: [true: passed; false: not passed]; datas: [the values of the selected records]###
#    isConditionPass = ->
#      result = {passed: false, datas: []}
#      result.datas.push key for key, isSelected of options.checkDatas.items when isSelected
#      switch options.attributes[CSS.WEIGHING]
#        when '*'
#          cssPass = isCssPass(result.datas)
#          result.passed = cssPass.passed
#          if !result.passed
##            rows = []
##            rows.push($(options.checkDatas.elements[key]).index() + 1) for key, passed of cssPass.datas when !passed
##            alert "[the #{rows} rows] #{INFO.REJECT_MULTIPLE}"
#            alert INFO.REJECT_MULTIPLE
#        when '1'
#          switch result.datas.length
#            when 0 then alert INFO.NO_SELECTED
#            when 1
#              cssPass = isCssPass(result.datas)
#              result.passed = cssPass.passed
#              alert INFO.REJECT_ONE if !result.passed
#            else alert INFO.ONLY_ONE
#        when '1+'
#          switch result.datas.length
#            when 0 then alert INFO.NO_SELECTED
#            else
#              cssPass = isCssPass(result.datas)
#              result.passed = cssPass.passed
#              if !result.passed
##                rows = []
##                rows.push($(options.checkDatas.elements[key]).index() + 1) for key, passed of cssPass.datas when !passed
##                alert "[the #{rows} rows] #{INFO.REJECT_MULTIPLE}"
#                alert INFO.REJECT_MULTIPLE
#        when '2'
#          switch result.datas.length
#            when 2
#              cssPass = isCssPass(result.datas)
#              result.passed = cssPass.passed
#              alert "#{INFO.REJECT_TWO}" if !result.passed
#            else alert INFO.ONLY_TWO
#        else
#
#      return result
#
#    ### @function:  isCssPass | is the status correct to perform this action
#        @param: keys | the values of the selected records
#        @return: an json object; passed: [true: passed; false: not passed]; datas: [the values of the selected records]###
#    isCssPass = (keys)->
#      result = {passed: true, datas: {}}
#      return result if keys.length is 0
#      for key in keys
#        classes = {}
#        classes[css] = css for css in $(options.checkDatas.elements[key]).attr('class').split(/\s+/) # get the class attribute of tr which is selected
#        if options.attributes[CSS.REJECT_CSS]?
#          for css in String(options.attributes[CSS.REJECT_CSS]).split(/\s+/) # if contains reject css, return false
#            if classes[css]? then result.passed = false; break else result.passed = true
#        else
#          result.passed = true
#        if result.passed
#          if options.attributes[CSS.REQUIRE_CSS]?
#            for css in String(options.attributes[CSS.REQUIRE_CSS]).split(/\s+/) # if not contains all of the require css, return false
#              if !classes[css]? then result.passed = false; break else result.passed = true
#          else
#            result.passed = true
#        result.datas[key] = result.passed
#      return result
#
#    ### @function: getCheckDatas
#        @illustrate: return options.checkDatas
#        @return: options.checkDatas ###
#    getCheckDatas = ->
#      return options.checkDatas
#
#    ### @function: setAttributes
#        @illustrate: assigning the value to the options.attributes
#        @return: void ###
#    setAttributes = (attrs)->
#      options.attributes = attrs
#
#    ### @function: getQueryData
#        @return: options.queryData ###
#    getQueryData = ->
#      return options.queryData

    return {
      init: init
#      gotoState: gotoState
#      perform: perform
#      refresh: refresh
#      setAttributes: setAttributes
#      getCheckDatas: getCheckDatas
#      getQueryData: getQueryData
    }
  ])