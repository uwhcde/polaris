Polaris.Users = do ->
  _thisUsers = null

  addPreview = (component, preview) ->
    previewContainer = $(preview)
    $(component).change (e) ->
      previewContainer.removeProp 'background-image'
      reader = new FileReader

      reader.onload = (e) ->
        previewContainer.css 'background-image', 'url(' + e.target.result + ')'
        return

      reader.readAsDataURL @files[0]
      return

  addInfiniteScroll = ->
    if $('.pagination').length
      $(window).scroll ->
        url = $('.pagination .next_page').attr('href')
        if url and $(window).scrollTop() > $(document).height() - $(window).height() - 50
          $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
          return $.getScript url
        return
      return $(window).scroll()

  init: ->
    if $('.js-user-profile').length > 0
      addPreview '#user_cover_image', '.user-profile-cover'
      addPreview '#user_picture', '.user-profile-picture'
      addInfiniteScroll()
