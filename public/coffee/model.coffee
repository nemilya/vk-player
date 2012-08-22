class Model
  is_group_configured: ->
    @get_gid()?

  get_gid: ->
    @gid

  set_gid: (gid) ->
    @gid = gid

  groups: ->
    [{title: 'title1', gid: 1}, {title: 'title2', gid: 2}]

  audios: ->
    [{title: 'test', mp3: '/mp3/test.mp3'}, {title: 'test2', mp3: '/mp3/test.mp3'}]

root = this ? this : exports
root.Model = Model