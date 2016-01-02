Polaris.Bootstrap = do ->

  _init = ->
    _initPageTransitions()


  _initPageTransitions = ->
    document.addEventListener 'page:change', ->
      document.querySelector('main').className = 'animated fade-in-up-sm'

    document.addEventListener 'page:fetch', ->
      document.querySelector('main').className = 'animated fade-out-down-sm'

  init: ->
    _init()
