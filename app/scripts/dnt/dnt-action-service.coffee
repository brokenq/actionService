###
  ＝＝＝＝＝＝＝＝＝＝＝＝   ActionService   ＝＝＝＝＝＝＝＝＝＝＝＝
  ＝＝＝＝＝＝＝＝＝＝＝＝   Start Guide     ＝＝＝＝＝＝＝＝＝＝＝＝
  1.dnt-service(service='ActionService') | declare in the jade page

  ＝＝＝＝＝＝＝＝＝＝＝＝     Reference     ＝＝＝＝＝＝＝＝＝＝＝＝
  @function:bindSelection（） | bind to the table
    @param:selectedObj | the selected data object
  @variable:selectedDatas | the selected datas
###
angular.module 'dnt.action.service', [
  'ui.router'
]
  .factory 'ActionService', ['$state', '$filter', ($state, $filter)->
    datas = {}  # the datas of the table
    selectedDatas = {} # the selected datas

    bindSelection = (selectedObj)->
      console.log selectedObj
      selectedDatas = selectedObj

    gotoState = (state)->
      $state.go state
#      console.log 'gotoSate start: checkboxes:' + $filter('json')(checkboxes)

    getSelectedDatas = ()->
      return selectedDatas

    return {
      bindSelection: bindSelection
      gotoState: gotoState
      getSelectedDatas: getSelectedDatas
    }
  ]