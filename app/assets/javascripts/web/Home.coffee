Polaris.Home = do ->
  _thisUsers = null

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
    if $('.js-home').length > 0
      addInfiniteScroll()
