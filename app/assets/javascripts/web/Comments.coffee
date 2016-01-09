Polaris.Comments = do ->

  _init = ->
    $('.js-comments').on('submit', '.js-new-comments-form', _handleCommentSubmit)

  _handleCommentSubmit = (event) ->
    event.preventDefault()
    url = $(this).attr('action')
    $.ajax
      url: url
      type: 'POST'
      dataType: 'JSON'
      data: $(this).serialize()
      success: (data) ->
        console.log data


  init: ->
    if $('.js-votes').length > 0
      _init()
