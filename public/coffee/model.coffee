class Model
  is_group_configured: ->
    @get_gid()?

  get_gid: ->
    @gid

  set_gid: (gid) ->
    @gid = gid

  groups: ->
    @_groups

  init_groups: (callback) ->
    if VK?
      VK.api 'groups.get', extended: 1, (data) =>
        @_groups = []
        if data.response
          groups = data.response
          groups.shift()
          for group in groups
            @_groups.push { gid: group.gid, title: group.name }
        callback(@)
    else
      @_groups = [{title: 'title1..', gid: 1}, {title: 'title2..', gid: 2}]
      callback(@)



  audios: ->
    @_audios

  init_audios: (callback) ->
    if VK?
      params = 
        gid: @get_gid()
        count: 7
      console.log params
      VK.api 'audio.get', params, (data) =>
        if data.response
          @_audios = []
          for m in data.response
            item = {}
            item.title = m.artist + ' ' + m.title
            item.mp3   = m.url
            @_audios.push(item)
          callback(@)
    else
      @_audios = [{title: 'test', mp3: '/mp3/test.mp3'}, {title: 'test2', mp3: '/mp3/test.mp3'}]
      callback(@)

root = this ? this : exports
root.Model = Model