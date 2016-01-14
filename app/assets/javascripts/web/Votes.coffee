Polaris.Votes = do ->
  _thisVotes = null

  _init = ->
    $('.js-votes').on('click', '.js-poll-vote', _handleVoteUp)

  _handleVoteUp = (event) ->
    console.log "Here.."
    event.preventDefault()
    _this = $(this)
    url = _this.attr('href')
    $.ajax
      url: url
      type: 'POST'
      dataType: 'json'
      success: (data) ->
        _thisVotes = _this.parents('.js-votes:first')
        _thisVotes.find('.js-upvotes').text(data.votes.upvotes)
        _thisVotes.find('.js-downvotes').text(data.votes.downvotes)


  init: ->
    if $('.js-votes').length > 0
      _init()
