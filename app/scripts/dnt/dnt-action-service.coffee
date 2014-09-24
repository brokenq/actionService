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
    selectedDatas = {items: {}, elements: {}}
    attributes = null  # the attributes of the button which you click

    CSS =
      WEIGHING: 'weighing'
      REQUIRE_CSS: 'requireCss'
      REJECT_CSS: 'rejectCss'
    INFO =
      NO_SELECTED: "you don't select any record"
      REJECT: "this record can't be perform in this action, please check the status"
      ONLY_ONE: "you can only select one record to perform this action"

    ### @function: init
        @illustrate: initialize the ActionService
        @return: void ###
    init = (datas)->
      selectedDatas = datas

    ### @function: gotoState
        @illustrate: redirect to the state page
        @return: void ###
    gotoState = (state)->
      condition = isPass()
      $state.go state, {id: condition.datas[0]} if condition.passed
      removeAttributes()

    ### @function: isPass
        @illustrate: prerequisite which you can perform the action
        @return: [true: passed; false: not passed] ###
    isPass = ()->
      datas = [] # the checked datas
      passed = false

      angular.forEach selectedDatas.items, (isSelected, key)->  # get the checked datas
        datas.push key if isSelected

      if datas.length is 0
        alert INFO.NO_SELECTED
      else
        switch attributes[CSS.WEIGHING]
          when '1'
            if datas.length is 1
              passed = isCssPass(datas)
              alert INFO.REJECT if !passed
            else
              alert INFO.ONLY_ONE
#          when '1+'
#          when '2'
#          when '*'
      return {datas: datas, passed: passed}

    ### @function:  isCssPass
        @illustrate:  is the status correct to perform this action
        @return: [true: passed; false: not passed] ###
    isCssPass = (keys)->
      classes = {}
      for key in keys
        classes[val] = val for val in $(selectedDatas.elements[key]).attr('class').split(' ')
      return false for css in String(attributes[CSS.REJECT_CSS]).split(' ') when classes[css]?
      return false for css in String(attributes[CSS.REQUIRE_CSS]).split(' ') when !classes[css]?
      return true

    perform = (callback)->
      console.log callback
#      $apply funcName
#      fn = $parse funcName
#      console.log fn
#      $rootScope.$apply ->
#        fn $rootScope, {event: null}
      console.log 'perform'
#      console.log window[funcName]
#      fn = window[funcName]
#      fn funcName
      removeAttributes()

    setAttributes = (attrs)->
      attributes = attrs

    removeAttributes = ()->
      attributes = null

    return {
      init: init
      gotoState: gotoState
      perform: perform
      setAttributes: setAttributes
    }
  ]