###
  = Polaris =
  Creates the Polaris Object and inits different components of Polaris
###

window.Polaris = do ->
  _config = {}
  ###
    == Polaris.init ==
    This function is called after the dom is ready to and **$** is available
  ###
  init: ->
    new Post()
    return true



  ###
    == Polaris.config ==
    Returns the config hash set in the init function

    //Returns//
    * **config** : A hash that is an application level config which is set on the server side
  ###
  config: ->
    _config
$(Polaris.init)
