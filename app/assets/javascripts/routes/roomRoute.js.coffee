# @TODO:
# - list rooms you're in
# - autocomplete helper to create a new room

# Route to handle our room
Converse.RoomRoute = Ember.Route.extend
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