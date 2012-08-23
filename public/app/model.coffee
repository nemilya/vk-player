class Model
  is_group_configured: ->
    @get_gid()?

  get_gid: ->
    @gid

  set_gid: (gid) ->
    @gid = gid

  set_random: (rand) ->
    @random = rand

  get_random: -> @random

  groups: ->
    @_groups

  audios_cnt: ->
    @_audios_cnt

  random_offset: ->
    @_random_offset

  get_offset: ->
    if @_audios_cnt? and @get_random()
      return Math.floor(Math.random() * @_audios_cnt)
    else
      return 0

  init_audios_cnt: (callback) ->
    if VK?
      VK.api 'audio.getCount', {oid: -1 * @get_gid()}, (data) =>
        if data.response
          @_audios_cnt = data.response
        callback()
    else
      @_audios_cnt = 7
      callback()

  init_groups: (callback) ->
    if VK?
      VK.api 'groups.get', extended: 1, (data) =>
        @_groups = []
        if data.response
          groups = data.response
          groups.shift()
          for group in groups
            @_groups.push { gid: group.gid, title: group.name }
        callback()
    else
      @_groups = [{title: 'title1..', gid: 1}, {title: 'title2..', gid: 2}]
      callback()

  audios: ->
    @_audios

  init_audios: (callback) ->
    if VK?
      params = 
        gid: @get_gid()
        offset: @get_offset()
        count: 7
      console.log params
      VK.api 'audio.get', params, (data) =>
        console.log data.response
        if data.response
          @_audios = []
          for m in data.response
            item = {}
            item.title = m.artist + ' - ' + m.title
            item.mp3   = m.url
            @_audios.push(item)
          callback()
    else
      @_audios = [{title: 'test', mp3: '/assets/mp3/test.mp3'}, {title: 'test2', mp3: '/mp3/test.mp3'}]
      callback()

root = this ? this : exports
root.Model = Model