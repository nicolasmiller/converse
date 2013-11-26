# Route to handle our room
Converse.IndexRoute = Ember.Route.extend
  
  model: (params) ->
    users = @paramsAsString(params)
    EmberFire.Array.create
      ref: new Firebase("https://converse-chat.firebaseio.com/rooms/#{users}/messages")

  # extract params into to create request
  paramsAsString: (params) ->
    r = []
    for key, val of params
      r.push val.replace("@", "") if val.indexOf("@") isnt -1
    r.sort().toString()


Converse.IndexController = Ember.ArrayController.extend
  actions:
    startAuth: ->
      auth.login('twitter')