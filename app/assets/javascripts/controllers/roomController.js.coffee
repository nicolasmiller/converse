Converse.RoomController = Ember.ArrayController.extend
  msg: ""
  user: ""
  nickname: "@"
  actions:
    addMessage: ->
      @pushObject
        from: @get('nickname')
        msg: @get('msg')

      @set "msg", null