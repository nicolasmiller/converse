# Route to handle our room
Converse.RoomRoute = Ember.Route.extend
  
  model: (params) ->
    users = @paramsAsString(params)

    # Set AWS config
    # @TODO: get tokens from server rather than set them statically
    AWS.config.update
      accessKeyId: 'AKIAJOPZGEJIVXVNFLFQ'
      secretAccessKey: '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'
    AWS.config.region = 'us-west-1'

    # create reference to DynamoDB
    db = new AWS.DynamoDB
      params:
        TableName: 'votechat'

    # request correct conversation
    db.getItem
      'Key':
        'hash':
          'S': "room"
        'range': ""
      , (data) -> console.log data

    # posts.findBy 'id', params.post_id

  # extract params into to create request
  paramsAsString: (params) ->
    r = []
    for key, val of params
      r.push val.replace("@", "") if val.indexOf("@") isnt -1
    r.toString()