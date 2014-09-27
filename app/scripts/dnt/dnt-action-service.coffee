###
  ＝＝＝＝＝＝＝＝＝＝＝＝   ActionService   ＝＝＝＝＝＝＝＝＝＝＝＝
  ＝＝＝＝＝＝＝＝＝＝＝＝   Start Guide     ＝＝＝＝＝＝＝＝＝＝＝＝
  1.dnt-service(service='ActionService') | declare in the jade page

  ＝＝＝＝＝＝＝＝＝＝＝＝     Reference     ＝＝＝＝＝＝＝＝＝＝＝＝
  @function: init: initialize the ActionService
    @type: public
  @function: isPass: prerequisite which you can perform the action
    @type: private
  @function: isCssPass: is the status correct to perform this action
    @type: private
###
angular.module 'dnt.action.service', [
  'ui.router'
]
  .factory 'ActionService', ['$state', '$filter', '$parse', ($state, $filter, $parse)->
    # the data need to be control. items: the check data; elements: the elements of tr which are selected
    selectedDatas = {'checked': false, items: {}, elements: {}}
    attributes = null  # the attributes of the button which you click
    scope = null
    options =
      scope: null # required | assign the $scope of Controller to this
      datas: {items: {}, elements: {}} #
      attributes: null # not required | the attributes of the button which you click

    setEval = (obj)->
      scope = obj

      scope.$watch 'checkboxes.checked', (value) ->
        angular.forEach scope.phones, (item) ->
          scope.checkboxes.items[item.age] = value if angular.isDefined(item.age)

      scope.$watch('checkboxes.items', (newValue) ->
        #      $scope.$broadcast 'selectChanged', $scope.checkboxes
        return if !scope.phones
        checked = 0
        unchecked = 0
        total = scope.phones.length
        angular.forEach scope.phones, (item)->
          checked   +=  (scope.checkboxes.items[item.age]) || 0
          unchecked += (!scope.checkboxes.items[item.age]) || 0
        scope.checkboxes.checked = (checked == total) if (unchecked == 0) || (checked == 0)

        selectedKeys = []
        selectedKeys.push key for key, isSelected of newValue when isSelected
        scope.checkboxes.elements = {}
        scope.checkboxes.elements[selectedKeys[index]] = tr for tr, index in $('[dnt-service] table :checked').parent().parent()

        angular.element(document.getElementById("select_all")).prop("indeterminate", (checked != 0 && unchecked != 0))
      , true)


    CSS =
      WEIGHING: 'weighing'
      REQUIRE_CSS: 'requireCss'
      REJECT_CSS: 'rejectCss'
    INFO =
      NO_SELECTED: "you don't select any record"
      REJECT_ONE: "this record can't be perform in this action, please check the status"
      REJECT_TWO: "the two records can't be perform in this action, please check the status"
      REJECT_MULTIPLE: "these records can't be perform in this action, please check the status"
      ONLY_ONE: "you can only select one record to perform this action"
      ONLY_TWO: "you must select two records to perform this action"
      ONE_AT_LEAST: "you must select one record at least to perform this action"

    ### @function: init
        @illustrate: initialize the ActionService
        @return: void ###
    init = (optionsParam)->
#      options.scope = optionsParam.scope if optionsParam.scope?
#      options.datas = optionsParam.datas if optionsParam.datas?
      selectedDatas = optionsParam

    ### @function: gotoState
        @illustrate: redirect to the state page
        @return: void ###
    gotoState = (state)->
      condition = isConditionPass()
      $state.go state, {id: condition.datas[0]} if condition.passed
      removeAttributes()

    perform = (callback)->
      condition = isConditionPass()
      scope.$eval(callback) if condition.passed
      removeAttributes()

    ### @function: isPass
        @illustrate: prerequisite which you can perform the action
        @return: [true: passed; false: not passed] ###
    isConditionPass = ()->
      result = {passed: false, datas: []}
      result.datas.push key for key, isSelected of selectedDatas.items when isSelected
      if result.datas.length is 0
        alert INFO.NO_SELECTED
      else
        switch attributes[CSS.WEIGHING]
          when '1'
            if result.datas.length is 1
              cssPass = isCssPass(result.datas)
              result.passed = cssPass.passed
              alert INFO.REJECT_ONE if !result.passed
            else
              alert INFO.ONLY_ONE
          when '1+'
            if result.datas.length >= 1
              cssPass = isCssPass(result.datas)
              result.passed = cssPass.passed
              if !result.passed
                rows = []
                rows.push key for key, isSelected of cssPass.datas when !isSelected
                alert "#{rows} #{INFO.REJECT_MULTIPLE}"
            else
              alert INFO.ONE_AT_LEAST
          when '2'
            if result.datas.length is 2
              cssPass = isCssPass(result.datas)
              result.passed = cssPass.passed
              alert "#{INFO.REJECT_TWO}" if !result.passed
            else
              alert INFO.ONLY_TWO
#          when '*'
      return result

    ### @function:  isCssPass
        @illustrate:  is the status correct to perform this action
        @return: [true: passed; false: not passed] ###
    isCssPass = (keys)->
      result = {passed: false, datas: {}}
      for key in keys
        classes = {}
        classes[css] = css for css in $(selectedDatas.elements[key]).attr('class').split(/\s+/)
        if attributes[CSS.REJECT_CSS]?
          for css in String(attributes[CSS.REJECT_CSS]).split(/\s+/)
            if classes[css]?
              result.passed = false
              break
            else
              result.passed = true
        else
          result.passed = true
        if result.passed
          if attributes[CSS.REQUIRE_CSS]?
            for css in String(attributes[CSS.REQUIRE_CSS]).split(/\s+/)
              if !classes[css]?
                result.passed = false
                break
              else
                result.passed = true
          else
            result.passed = true
        result.datas[key] = result.passed
      return result

    setAttributes = (attrs)->
      attributes = attrs

    removeAttributes = ()->
      attributes = null

    return {
      init: init
      gotoState: gotoState
      perform: perform
      setAttributes: setAttributes
      setEval: setEval
    }
  ]