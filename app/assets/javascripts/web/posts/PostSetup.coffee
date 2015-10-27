###
  This class manages whole post setup page
###
class PostSetup
  MAX_SECTION_LENGTH = 2
  MAX_SUB_SECTION_DEPTH = 3
  addNewStep = null

  # ### constructor
  # Manages sections for posts
  #
  constructor: ->
    # Declarations
    addNewStep()
    removeStep()

  removeStep = ->
    $(document).on 'click', '.js_remove_step' , (e) ->
      e.preventDefault()
      $(e.target).parents('.card').remove()


  addNewStep = ->
    addButton = $('.js_add_new_step')
    addButton.on 'click', ->
      $('.steps').append($('.card').clone())

  _confirmWhenUserLeaves: ->
    if $('.hideFields').length
      e = event || window.event

      # For IE and Firefox prior to version 4
      e.returnValue = _confirmLeaveText if e
      # For others
      return _confirmLeaveText;


@PostSetup = PostSetup
