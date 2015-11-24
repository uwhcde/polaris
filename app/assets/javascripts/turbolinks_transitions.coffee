document.addEventListener 'page:change', ->
        document.getElementById('primary-content').className += ' animated fadeIn'

document.addEventListener 'page:fetch', ->
        document.getElementById('primary-content').className += ' animated fadeOut'