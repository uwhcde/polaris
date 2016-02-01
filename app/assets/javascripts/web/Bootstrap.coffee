Polaris.Bootstrap = do ->

  _init = ->
    _initPageTransitions()


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

  initTimePicker: ->
    $('.datetimepicker').datetimepicker();

  init: ->
    _init()
    Polaris.Bootstrap.initTimeAgo()
    Polaris.Bootstrap.initPlaceComplete()
    Polaris.Bootstrap.initTimePicker()
