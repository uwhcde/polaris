Polaris.Form = {} unless Polaris.Form?
###
  =Polaris.Form.Attachment=
  This module is handles the uploading of attachment from any kso post form
###
Polaris.Form.Attachment = do ->
  'use strict'
  _attachmentUpload = null
  _attachmentModal = null
  _AttachmentId = null
  _uploadImageLink = null
  _fileInputBox = null
  TIMEOUT = (1000 * 60 * 60) # 1 Hour
  PREVIEW_MAX_WIDTH = 60
  PREVIEW_MAX_HEIGHT = 60
  MAX_NUMBER_OF_FILES = 1
  LIMIT_CONCURRENT_UPLOADS = 1
  DROP_TEXT = "Dopti"
  DRAG_DROP_TIMEOUT = 500 # 500 Milli seconds


  ###
    == //_init// ==
  ###
  _init = ->
    # Attach the click handler to the file upload event
    $(document).on('click', '.AttachmentUpload:visible input:file', _attachmentClickHandler)


  ###
    == //_attachmentClickHandler// ==
    Creates the file upload panel
    Changes the button to jquery ui based buttons
    Reads the current list of attachments from the container's config and creates the file list
  ###
  _attachmentClickHandler = (event, setFileUploadContainer = true) ->
    # Clear all tootips
    if event.type is "click"
      _attachmentUpload = $(this).closest('form').find('.AttachmentUpload:first') if setFileUploadContainer
    else if event.type is "dragover"
      _attachmentUpload = $(event.target).closest('form').find('.AttachmentUpload:first')
    else
      return
    _loadFileUploadDefaults()
    event.stopPropagation()

  _loadFileUploadDefaults = ->
    # File Upload
    # url = _attachmentUpload.data("url")
    _fileInputBox = _attachmentUpload.find("input:file:first")
    _uploadImageLink = _attachmentUpload.find("input:file:first").parents('.attachFileLink')

    _attachmentUpload.each ->
      $(this).fileupload
        url: '/media/pictures?responseType=json&authenticity_token=' + $('[name="authenticity_token"]').val()
        timeout: TIMEOUT
        previewMaxWidth: PREVIEW_MAX_WIDTH
        previewMaxHeight: PREVIEW_MAX_HEIGHT
        limitConcurrentUploads: LIMIT_CONCURRENT_UPLOADS
        uploadTemplateId: ""
        downloadTemplateId: ""
        maxNumberOfFiles: MAX_NUMBER_OF_FILES
        autoUpload: true
        dropZone: $('.guide-new-header')
        type: "POST"

    if _AttachmentId isnt 0
      _attachmentUpload.data("attachment-id", _AttachmentId)
    else
      _attachmentUpload.data("attachment-id", 0)
    ## Use this method in future if required to trigger file upload with javascript.
    #_openFileUploadWindow()
    _attachmentUpload.bind('fileuploaddone', _fileUploadDone)
    _attachmentUpload.bind('fileuploaddestroy', _filedeleteDone)
    _attachmentUpload.bind('fileuploadcompleted', _fileuploadCompleted)
    _attachmentUpload.bind('fileuploadstart', _fileuploadStart)
    _attachmentUpload.bind('fileuploadstop', _fileuploadStop)
    _attachmentUpload.bind('fileuploadadded', _fileuploadAdded)


  # ### _fileuploadAdded
  #
  # Whenever a file is added for uploading the submit button in the form
  # is disabled. So that the form is not submitted without the completion
  # of file upload.
  #
  _fileuploadAdded = (event, data) ->
    $(".cu-status").attr('class', "cu-status fileupload-added")

  ###
    == //_fileUploadStart// ==
    Runs when the file upload starts
  ###
  _fileuploadStart = (event, data) ->
    $(".cu-status").attr('class', "cu-status fileupload-start")

  ###
    == //_fileUploadStop// ==
    Runs when the file upload stops
  ###
  _fileuploadStop = (event, data) ->
    $(".cu-status").attr('class', "cu-status fileupload-stop")

  ###
    == //_fileUploadDone// ==
    Executed when fileupload is done. appends the uploaded file id to the
    AttachmentId so that they can be referenced when the attachment is saved
  ###
  _fileUploadDone = (event, data) ->
    target = $(event.target)
    _attachmentUpload = $(event.target)
    $(".cu-status").attr('class', "cu-status fileupload-done")
    url = data.result.files[0].url
    console.log(data.result.files[0].id)
    $('.cover_id').attr('value', data.result.files[0].id)
    $(".guide-new-header").css
      'background-image': "url(#{url})"



    # unless data.result.files[0].id is undefined
    #   if _attachmentUpload.find('#microblog_id_of_attachment').length isnt 0
    #     _attachmentUpload.find('#microblog_id_of_attachment').val(newId)
    #   else if _attachmentUpload.closest('.js_create_conversation').length
    #     $('#js_create_conversation_attachment_id', _attachmentUpload.closest('.js_create_conversation')).val(newId)
    #     $('.Polaris_submit_button_form', _attachmentUpload.closest('form')).removeAttr('disabled')
    #   else
    #     _attachmentUpload.data("attachment-id", newId)
    #   target.attr("data-attachment-id", newId)
    #   target.find("input:file:first").prop("disabled", true)
    #   $('.fileupload-error').parents(".template-download").remove()
    # else
    #   $('.remove_error').live 'click', -> $(this).parents(".template-download").remove()

  _fileuploadCompleted = (event) ->
    $(".cu-status").attr('class', "cu-status fileupload-completed")
    $(".template-download").attr('style', "")

  _showFileUploadInput = (event) ->
    _fileInputBox.toggle()

  _filedeleteDone = (event, data) ->
    $(".cu-status").attr('class', "cu-status fileupload-deletedone")
    target = $(event.target)
    if target.hasClass 'js_attachment_container'
      target.closest('.js_cf_dock').find('.js_attachment_id').val('')
    else if target.closest('.js_create_conversation').length
      $('#js_create_conversation_attachment_id', target.closest('.js_create_conversation')).val('')
    else
      microblogText = target.parents("form:first").find('textarea.createMicroblogTextarea, textarea.commentsReplyTextarea, textarea.conversationsReplyTextarea')
    if microblogText isnt undefined and microblogText.val().trim().length >= parseInt(Polaris.config().microblog.minLength)
      target.parents("form:first").find('#post_button, .Polaris_submit_button_form').prop("disabled", false)
    _attachmentUpload.attr('data-attachment-id', 0)
    _fileInputBox.val('')
    _attachmentUpload.find('#microblog_id_of_attachment').val('')
    target.find('input:file').prop('disabled', false)


  _openFileUploadWindow = ->
    # Open up the classic file upload box
    if _attachmentUpload.data("attachment-id") in ["", 0, "0"]
      _fileInputBox.trigger("click")
    false

  # ### addMediaFileToMicroblog
  # Adds media file to microblog
  #
  addMediaFileToMicroblog: (data) ->
    newMicroblogPost = $('.js_create_new_post')
    newMicroblogPost.trigger 'click'
    microblogForm = $('.js_microblog_create_form:first')
    $('#microblog_id_of_attachment', microblogForm).val(data.files[0].id)
    $('.files:first', microblogForm).html(tmpl("kso-template-download", data))

  # ### Polaris.Form.Attachment.handleTextAreaOnDragOver
  #
  # When a file is dragged on the the text area, initializes the jquery file upload plugin
  # for nearest file upload input.
  #
  # **event** - the event from the dragover event
  # **textArea** - the textarea to which the drag and drop to be enabled
  # **thiz** - the this object from the event
  # **placeholderText** - the placeholder text of the textarea
  handleTextAreaOnDragOver: (event, textArea, thiz, placeholderText) ->
    textArea.focus()
    dropZone = $(thiz)
    try
      # Try whether the file upload plugin is initialized on the element.
      $(event.target).closest('form').find('.AttachmentUpload:first').fileupload('progress')
    catch error
      # if there is any error then we will initialize the plugin on the element.
      Polaris.Form.Attachment.initFromDrop(event)

    Polaris.Form.Attachment.dropZoneAnimate(event, textArea, thiz, placeholderText)

  # ## Polaris.Form.Attachment.dropZoneAnimate
  #
  # This is the generic function used to animate the drop area when the file is dragged over
  # the text area.
  #
  # **thiz** - the `this` from the dragover event
  # **event** - the `event` from the dragover action
  # **textArea** - the jQuery object of the text area
  # **placeholderText** - The place holder text of the textarea
  #
  dropZoneAnimate: (event, textArea, thiz, placeholderText)->
    textArea.focus()
    dropZone = $(thiz)
    # The following code is take from
    # https://github.com/blueimp/jQuery-File-Upload/wiki/Drop-zone-effects
    timeout = window.dropZoneTimeout
    if timeout
      clearTimeout timeout
    else
      dropZone.addClass "dropZoneActive"
      textArea.attr("placeholder", DROP_TEXT)
      dropZone.css "height", 70
    found = false
    node = event.target
    loop
      if node is dropZone[0]
        found = true
        break
      node = node.parentNode
      break unless node?
    if found
      dropZone.addClass "hover"
    else
      dropZone.removeClass "hover"
    window.dropZoneTimeout = setTimeout(->
      window.dropZoneTimeout = null
      dropZone.css "height", 50
      dropZone.removeClass "dropZoneActive hover"
      textArea.attr("placeholder", placeholderText)
    , DRAG_DROP_TIMEOUT)

  # Initiate Event handlers for the attachments
  initUploadAttachment: ->
    _attachmentUpload = $('.cover-upload')
    _loadFileUploadDefaults()

  # ## Polaris.Form.Attachment.init
  #
  # Should be called during page load
  #
  init: ->
    if $('.cover-upload').length isnt 0
      Polaris.Form.Attachment.initUploadAttachment()
      _init()
    # Disabled the default drag and dragover actions
    $('body').bind 'drop dragover', (event) -> event.preventDefault()

  # ## Polaris.Form.Attachment.initFromDrop
  #
  # Initializes the file upload when the file is dragged-over the microblog form.
  #
  initFromDrop: (event) ->
    if $('.cover-upload').length isnt 0
      _attachmentClickHandler(event)
