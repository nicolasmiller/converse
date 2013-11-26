# @TODO:
# - @reply :)
# - @ autocomplete

# Route to handle our room
Converse.RoomsRoute = Ember.Route.extend
  
  model: (params) ->
    a = EmberFire.Array.create
      ref: new Firebase("https://converse-chat.firebaseio.com/rooms")
    console.log store = @get 'store'
    a