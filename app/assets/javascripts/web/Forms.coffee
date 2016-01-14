Polaris.Forms = do ->
  _thisVotes = null

  _init = ->
    $('.help-type').on('change', '[name="help[help_type]"]', _handleChange)

  _handleChange = ->
    console.log $(this).val()
    if $(this).val() is 'true'
      $('.new-card').attr('class', 'new-card help-request')
    else
      $('.new-card').attr('class', 'new-card help-offered')



  init: ->
    _init()
