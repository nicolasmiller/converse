var main = {};
main.history_size = 10;
main.messages = [];
main.room = 'general';  // make this switchable etc

main.nuke = function() {
  main.messages = [];
  main.put_messages();
};

// {
//   'hash': 'room',
//   'range': 'general'
//   'message0': 'foo bar baz'
// }
main.put = function(hash, range, o, f) {
  var item = {'Item': {'hash': {'S': hash}, 'range': {'S': range}}};
  for (var key in o) {
      if (o.hasOwnProperty(key) && (typeof o[key] === 'string')) {
        item['Item'][key] = {'S': o[key]};
      }
  }

  main.dy.putItem(item, f);
};

main.get = function(hash, range, callback) {
  main.dy.getItem({'Key': {'hash': {'S': hash}, 'range': {S: range}}}, callback);
};

main.delete = function(hash, range, callback) {
  main.dy.deleteItem({'Key': {'hash': {'S': hash}, 'range': {S: range}}}, callback);
};

$(document).ready(function() {
  var i;
  AWS.config.update({accessKeyId: 'AKIAJOPZGEJIVXVNFLFQ', secretAccessKey: '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'});
  AWS.config.region = 'us-west-1';
  main.dy = new AWS.DynamoDB({params: {TableName: 'votechat'}});
  // main.dy.listTables(function(err, data) {
  //    console.log(data.TableNames);
  // });

     // var key = 'wtf';
    // var itemParams = {'Item': {'hash': {'S': key}, 'range': {'S': '_'}, 'data': {'S': 'hello'}}};
    // main.dy.putItem(itemParams, function() {
    //     // Read the item from the table
    //     main.get(key, '_', function(err, data) {
    //         console.log(data.Item); // print the item data
    //     });
    // });

  // main.put(key, '_', {'data': 'foo'}, function() {
  //   main.get(key, '_', function(err, data) {
  //       console.log(err);
  //       console.log(data.Item);
  //   });
  //   main.delete(key, '_', function(err, data) {
  //       console.log(err);
  //       console.log(data.Item);
  //   });
  //   main.get(key, '_', function(err, data) {
  //       console.log(err);
  //       console.log(data.Item);
  //   });
  // });

  //   main.get('test', '_', function(err, data) {
  //       console.log(err);
  //       console.log(data.Item);
  //   });

  //   main.get('quux', '_', function(err, data) {
  //       console.log(err);
  //       console.log(data.Item);
  //   });

  $('body').keypress(function(e) {
      var code = e.keyCode || e.which;
      if(code == 13) { //Enter keycode
        main.send();
      }
  });

  for(i = 0; i < main.history_size; i++) {
    $('#chat').append($('<div id="message' + i + '"></div>'));
  }
  main.switch_room('general');
  main.switch_handle('anon');
  main.get_messages();
});

main.render_messages = function() {
  var i,
      size = main.messages.length;
  if(size === 0) {
      for(i = 0; i < main.history_size; i++) {
          $('#message' + i).text('');
      }
  }
  else {
      console.log('size: ' + size);
      for(i = 0; i < size; i++) {
          $('#message' + i).text(main.messages[i]);
      }
      for(i = size; i < main.history_size; i++) {
          $('#message' + i).text('');
      }
  }
};

main.put_messages = function() {
  var i,
    messages = {},
    size = main.messages.length;
  for(i = 0; i < size; i++) {
    messages['message' + i] = main.messages[i];      
  }
  main.put('room', main.room, messages, main.get_messages);
};

main.get_messages = function() {
    var i;
    main.get('room', main.room, function(err, data) {
        if(!err) {
            main.messages = [];
            for(i = 0; i < main.history_size; i++) {
              if(!data.Item['message' + i]) break;
              main.messages.push(data.Item['message' + i]['S']);
            }
            console.log(data.Item);
            main.render_messages();
        }
        else {
            main.put_messages();
//            console.log(err);
        }
    });
};

main.send = function() {
    var message = $('#message').val();
    if(message !== '') {
        main.get_messages();
        console.log(main.messages);
        setTimeout(function() {
        $('#message').val('')
        main.messages.push(main.handle + ': ' + message);
        main.messages = main.messages.slice(-main.history_size);
        console.log(main.messages);
        main.put_messages();
        }, 100);
    }
};


main.switch_room = function(room) {
  if(!room) {
    main.room = $('#room').val();
  }
  else {
    main.room = room
    $('#room').val(room)
  }
  main.get_messages();
}

main.switch_handle = function(handle) {
  if(!handle) {
    main.handle = $('#handle').val();
  }
  else {
    main.handle = handle
    $('#handle').val(handle)
  }
}
