Polaris.Bootstrap = do ->

  _init = ->
    _initPageTransitions()


  initTimeAgo = ->
    $("abbr.timeago").timeago()

  _initPageTransitions = ->
    document.addEventListener 'page:change', ->
      document.querySelector('main').className = 'animated half fadeIn'

    document.addEventListener 'page:fetch', ->
      document.querySelector('main').className = 'animated half fadeOut'

  highlight: (element) ->
    element.effect( "highlight", "slow" );

  initTimeAgo: ->
    $("abbr.timeago").timeago()

  initPlaceComplete: ->
    options =
      placeholderText: "Start typing the address.."
    $('#gmaps-input-address').geocomplete()


  init: ->
    _init()
    Polaris.Bootstrap.initTimeAgo()
    Polaris.Bootstrap.initPlaceComplete()
