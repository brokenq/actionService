angular.module 'dnt.action.service', [
  'ui.router'
]
  #  ＝＝＝＝＝＝＝＝＝＝＝＝   ActionService   ＝＝＝＝＝＝＝＝＝＝＝＝
  #  func:bindSelection（） | bind to the table
  #  params:selected  | the datas of the table rows which are selected
  .factory 'ActionService', ['$state', '$filter', ($state, $filter)->
    datas = {}  # the datas of the table
    selectedDatas = {} # the selected datas
    checkboxes =
      checked: false
      items: {}
    bindSelection = (selected)->
      console.log(selected)
      selectedDatas = selected

    gotoState = (state)->
      console.log 'gotoSate start: checkboxes:' + $filter('json')(checkboxes)
      $state.go state

    return {
      bindSelection: bindSelection
      gotoState: gotoState
    }
  ]