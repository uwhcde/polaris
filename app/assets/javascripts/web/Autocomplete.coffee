Polaris.Autocomplete = do ->

  THEME = 'bootstrap'

  _selectorClass = ".js-auto-complete"
  _container = null
  _url = null


  _init = ->
    $(_selectorClass).select2
      theme: THEME

  init: ->
    # _url = Polaris.Common.Util.computePath("/user_prompt")
    if $(_selectorClass).length > 0
      _init()
