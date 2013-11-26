Converse.RoomController = Ember.ArrayController.extend
  message: ""
  nickname: "@"
  actions:
    addMessage: ->
      @pushObject
        from: @get('nickname')
        message: @get('message')
