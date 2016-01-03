Polaris.Votes = do ->

  _init = ->
    $('.js-votes').on('click', '.js-poll-vote', _handleVoteUp)

  _handleVoteUp = (event) ->
    event.preventDefault()
    url = $(this).attr('href')
    $.ajax
      url: url
      type: 'POST'
      dataType: 'JSON'
      success: (data) ->
        $('.js-upvotes').text(data.votes.upvotes)
        $('.js-downvotes').text(data.votes.downvotes)


  init: ->
    if $('.js-votes').length > 0
      _init()
