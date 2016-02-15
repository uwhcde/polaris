Polaris.Bookmarks = do ->
  _icon = null

  _init = ->
    $('.bookmark').on('click', '.js-bookmark', _handleVoteUp)

  _handleVoteUp = (event) ->
    event.preventDefault()
    _this = $(this)
    url = _this.attr('href')
    type = if _this.attr('type') is 'yes' then 'no' else 'yes'
    classname = if _this.attr('type') is 'yes' then 'i-star-full' else 'i-star-empty'

    $.ajax
      url: "#{url}?type=#{_this.attr('type')}"
      type: 'POST'
      dataType: 'json'
      success: (data) ->
        _icon = _this.find('span')
        _icon.attr('class', classname)
        _this.attr('type', type)

  init: ->
    if $('.bookmark').length > 0
      _init()
