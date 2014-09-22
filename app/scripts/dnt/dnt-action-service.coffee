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
    @param: funcName | name of the function which you want to perform
  @variable:selectedDatas | the selected datas
###
angular.module 'dnt.action.service', [
  'ui.router'
]
  .factory 'ActionService', ['$state', '$filter', ($state, $filter)->
    datas = {}  # the datas of the table
    selectedDatas = {} # the selected datas

    bindSelection = (selectedObj)->
      selectedDatas = selectedObj

    gotoState = (state)->
      angular.forEach selectedDatas, (value, key)->
        $state.go state, {id: key} if value

    perform = (funcName)->


    getSelectedDatas = ()->
      return selectedDatas

    return {
      bindSelection: bindSelection
      gotoState: gotoState
      getSelectedDatas: getSelectedDatas
    }
  ]