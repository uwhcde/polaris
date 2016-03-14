Polaris.Bootstrap = do ->

  _init = ->
    # _initPageTransitions()

  _initPageTransitions = ->
    document.addEventListener 'page:change', ->
      document.querySelector('main').className = 'animated half fadeIn'

    document.addEventListener 'page:fetch', ->
      document.querySelector('main').className = 'animated half fadeOut'

  highlight: (element) ->
    element.effect( "highlight", "slow" );

  slideShow: (element) ->
    $('.js-recent').slick
      slidesToShow: 6
      slidesToScroll: 6
      infinite: false
  initTimeAgo: ->
    $("abbr.timeago").timeago()

  initPlaceComplete: ->
    options =
      placeholderText: "Start typing the address.."
    $('#gmaps-input-address').geocomplete()

  initTimePicker: ->
    $('.datetimepicker').datetimepicker
      allowInputToggle: true

  init: ->
    _init()
    Polaris.Bootstrap.initTimeAgo()
    Polaris.Bootstrap.initPlaceComplete()
    Polaris.Bootstrap.initTimePicker()
    Polaris.Bootstrap.slideShow()
