# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready (e) ->
    user =
        updateMenuSelection: (activeMenuItem) ->
            $(".profile .post-type li.back").css "left", 
                    activeMenuItem.position().left + (activeMenuItem.width() / 2.0) - ($(".profile .post-type li.back").width() / 2.0)

        init: ->
            user.updateMenuSelection $(".profile .post-type li.active")
            $(".profile .post-type li").click (e) ->
                user.updateMenuSelection $(this)
                return

    user.init()
    return