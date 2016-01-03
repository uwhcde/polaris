Polaris.Bootstrap = do ->

  _init = ->
    _initPageTransitions()
    _initTimeAgo()


  _initTimeAgo = ->
    $("abbr.timeago").timeago()

  _initPageTransitions = ->
    document.addEventListener 'page:change', ->
      document.querySelector('main').className = 'animated fadeIn'

    document.addEventListener 'page:fetch', ->
      document.querySelector('main').className = 'animated fadeOut'

  init: ->
    _init()
