###
  ＝＝＝＝＝＝＝＝＝＝＝＝   ActionService   ＝＝＝＝＝＝＝＝＝＝＝＝
  ＝＝＝＝＝＝＝＝＝＝＝＝   Start Guide     ＝＝＝＝＝＝＝＝＝＝＝＝
  1.dnt-service(service='ActionService') | declare in the jade page

  ＝＝＝＝＝＝＝＝＝＝＝＝     Reference     ＝＝＝＝＝＝＝＝＝＝＝＝
  @function:  bindSelection（） | bind to the table
    @param: selectedObj | the selected data object
  @function:  gotoState() | direct to the state page
    @param: state | the state where you want to redirect to
  @function:  perform() | perform the function
    @param: func | the function which you want to perform
  @variable:selectedDatas | the selected datas
###
angular.module 'dnt.action.service', [
  'ui.router'
]
  .factory 'ActionService', ['$state', '$filter', ($state, $filter)->
    selectedDatas = {}
    attributes = null

    constant =
      WEIGHING: 'weighing'
      REQUIRE_CSS: 'requireCss'
      REJECT_CSS: 'rejectCss'

    bindSelection = (selectedObj)->
      selectedDatas = selectedObj

    register = (buttons)->
      @buttons = buttons

    gotoState = (state)->
#      params = []
#      angular.forEach @selectedDatas, (value, key)->
#        params.push(key) if value
#      alert("you can only select one record to perform this action") if params.length != 1
      condition = isPass()
      $state.go state, {id: condition.datas[0]} if condition.passed
      removeAttributes()

    isPass = ()->
      datas = []
      passed = false
      angular.forEach selectedDatas, (value, key)->
        datas.push(key) if value
      if datas.length == 0
        alert("you don't select any recode")
      else
        switch attributes[constant.WEIGHING]
          when '1'
            if datas.length == 1
              passed = true
            else
              alert("you can only select one record to perform this action")
#          when '1+'
#          when '2'
#          when '*'
      return {datas: datas, passed: passed}
#      if datas.length == 0
#        alert("you don't select any recode")
#        return {datas: datas, isPass: false}
#      if datas.length == 1 && attributes[constant.WEIGHING] == '1'
#        alert("you can only select one record to perform this action")
#        return {datas: datas, isPass: false}

    perform = (funcName)->
      console.log 'perform'
#      console.log angular.element
#      console.log window[funcName]
#      fn = window[funcName]
#      fn funcName
      removeAttributes()

    setAttributes = (attrs)->
      attributes = attrs

    removeAttributes = ()->
      attributes = null

    getSelectedDatas = ()->
      return selectedDatas

    getButtons = ()->
#      $.each @buttons.attr('type'), (index, btn)->
#        console.log btn
#      angular.forEach angular.element($(@buttons)).attr(), (item)->
#        console.log item
#      console.log angular.element(@buttons)
      return @buttons

    return {
      bindSelection: bindSelection
      register: register
      gotoState: gotoState
      perform: perform
      setAttributes: setAttributes
      getSelectedDatas: getSelectedDatas
      getButtons: getButtons
    }
  ]