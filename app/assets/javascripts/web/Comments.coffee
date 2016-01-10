Polaris.Comments = do ->

  _init = ->
    $('.js-comments').on('focus', '.js-comment-textarea', _expandCommentForm)
    $('.js-comments').on('blur', '.js-comment-textarea', _collapseCommentForm)
    $('.js-comments').on('submit', '.js-new-comments-form', _handleCommentSubmit)
    $('.js-comments').on('click', '.js-reply-link', _handleReplyForm)


  _handleReplyForm = (event) ->
    event.preventDefault()
    target = $(this)
    data =
      url: target.data('comment-url')
      postid: target.data('post-id')
      userid: target.data('user-id')
      parentid: target.data('comment-parent')
      full_name: target.data('user-name')
      picture: target.data('picture')
      authenticity_token: $('[name="authenticity_token"]').val()
      post_type: target.data('post-type')
    replyForm = $(tmpl('comment-reply-form', data))
    nestedList = $(this).parents('li:first').find("ul:first").find(".form:first")
    nestedList.html(replyForm)
    newTextArea = nestedList.find('.js-comment-textarea')
    newTextArea.focus()


  _expandCommentForm = (event) ->
    target = $(this)
    _initAutosize(target)
    if(target.val() is '')
      target.css('min-height', '+=40')

  _collapseCommentForm = (event) ->
    target = $(this)
    _initAutosize(target)
    if(target.val() is '')
      target.css('min-height', '-=40')


  _initAutosize = (element) ->
    autosize(element);

  _destroyAutosize = (element) ->
    autosize.destroy(element)

  _resetAutosize = (element) ->
    element.value = ''
    $(element).blur()

  _handleCommentSubmit = (event) ->
    event.preventDefault()
    url = $(this).attr('action')
    _this = $(this)
    $.ajax
      url: url
      type: 'POST'
      dataType: 'JSON'
      data: $(this).serialize()
      success: (data) ->
        newComment = $(tmpl('comment-display', data))
        nestedList = _this.parents('ul:first').find(".js-child-comments:first")
        nestedList.prepend(newComment)
        Polaris.Bootstrap.initTimeAgo()
        _this.parents('ul:first').find(".form").html('')
        _resetAutosize($('#js-new-comment').find('textarea')[0])
        Polaris.Bootstrap.highlight(newComment)


  init: ->
    if $('.js-comments').length > 0
      _init()

