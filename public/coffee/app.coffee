window.app = $.sammy ->
  @element_selector = '#content'
  @use(Sammy.Haml, 'haml')

model = new Model

app.get '#/', ->
  @app.swap('Hello!')
  if model.is_group_configured()
    @redirect('#/player')
  else
    @redirect('#/groups')

app.get '#/set_group', ->
  model.set_gid @params.gid
  @redirect '#/player'

app.get '#/groups', ->
  model.init_groups (model) =>
    @partial('/templates/groups.haml', groups: model.groups())
    

app.get '#/player', ->
  model.init_audios (model) =>
    @partial('/templates/player.haml', audios: model.audios()).then ->
      Player.init_play_list(model.audios())

if VK?
  VK.init ->
    app.clearTemplateCache()
    app.run('#/')
else
  app.clearTemplateCache()
  app.run('#/')
