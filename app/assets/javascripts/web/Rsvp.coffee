Polaris.Rsvp = do ->
  _icon = null

  _init = ->
    $('.rsvp').on('click', '.js-rsvp', _handleRSVP)

  _handleRSVP = (event) ->
    event.preventDefault()
    _this = $(this)
    url = _this.attr('href')
    type = if _this.attr('type') is 'no' then 'no' else 'yes'
    classname = if _this.attr('type') is 'no' then 'btn btn-primary js-rsvp' else 'btn btn-default js-rsvp'
    text = if _this.attr('type') is 'no' then 'RSVP' else 'You are going'

    $.ajax
      url: "#{url}?type=#{_this.attr('type')}"
      type: 'POST'
      dataType: 'json'
      success: (data) ->
        _this.attr('class', classname)
        _this.attr('type', type)
        _this.text(text)
        $('.js-rsvp-count').text(data.rsvp.rsvp)


  init: ->
    if $('.rsvp').length > 0
      _init()
