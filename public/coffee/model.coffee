class Model
  is_group_configured: ->
    @get_gid()?

  init_info_by_gid: (gid, callback) ->
    @set_gid(gid)
    console.log callback
    @init_audios_cnt (callback) =>
      @init_audios(callback)
  
  get_gid: ->
    @gid

  set_gid: (gid) ->
    @gid = gid

  groups: ->
    @_groups

  audios_cnt: ->
    @_audios_cnt

  init_audios_cnt: (callback) ->
    if VK?
      console.log '!!!'
      console.log callback
      VK.api 'audio.getCount', {oid: -1 * @get_gid()}, (data) =>
        if data.response
          console.log data.response
        console.log callback
        callback(@)
    else
      @_audios_cnt = 7
      callback(@)

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