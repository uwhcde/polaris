Polaris.Bootstrap = do ->

  _init = ->
    _initPageTransitions()


  initTimeAgo = ->
    $("abbr.timeago").timeago()

  _initPageTransitions = ->
    document.addEventListener 'page:change', ->
      document.querySelector('main').className = 'animated fadeIn'

    document.addEventListener 'page:fetch', ->
      document.querySelector('main').className = 'animated fadeOut'

  highlight: (element) ->
    element.effect( "highlight", "slow" );

  initTimeAgo: ->
    $("abbr.timeago").timeago()

  init: ->
    _init()
    Polaris.Bootstrap.initTimeAgo()
