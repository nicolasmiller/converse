Converse.IndexController = Ember.ArrayController.extend
  actions:
    startAuth: ->
      chatRef = new Firebase('https://converse-chat.firebaseio.com/')
      auth = new FirebaseSimpleLogin chatRef, (error, user) =>
        if (error)
          alert "ERROR"
          console.log(error);
        else if (user)
          console.log 'LOGGED IN', user
          @transitionTo 'rooms'

      auth.login('twitter')