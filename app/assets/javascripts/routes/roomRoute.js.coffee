# Route to handle our room
Converse.RoomRoute = Ember.Route.extend
  
  model: (params) ->
    # extract users into array to create request
    r = []
    for key, val of params
      r.push val if val.indexOf("@") isnt -1

    # console.log r

    # request server keys with array

    # request conversation with keys
  

    # posts.findBy 'id', params.post_id