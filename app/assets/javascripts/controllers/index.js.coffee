Converse.IndexController = Ember.ArrayController.extend
  actions:
    startAuth: ->
      chatRef = new Firebase('https://converse-chat.firebaseio.com/')
      auth = new FirebaseSimpleLogin chatRef, (error, user) =>
        if (error)
          # console.log(error);
        else if (user)
          # console.log('User ID: ' + user.id + ', Provider: ' + user.provider);
        else
          # // user is logged out

      auth.login('twitter')