window.app = $.sammy ->
  @element_selector = '#content'
  @use(Sammy.Haml, 'haml')

app.model = new Model

app.get '#/wait', ->
  @partial 'wait.haml'

app.get '#/', ->
  @app.swap('Hello!')
  if @app.model.is_group_configured()
    @redirect('#/player')
  else
    @redirect('#/groups')

app.get '#/set_group', ->
  @partial 'wait.haml'
  @app.model.set_gid(@params.gid)
  @app.model.set_random(@params.random?)
  @redirect '#/_model_init_cnt'

app.get '#/_model_init_cnt', ->
  @app.model.init_audios_cnt =>
    @redirect '#/_model_init_audios'
  
app.get '#/_model_init_audios', ->
  @app.model.init_audios =>
    @redirect '#/player'
  
app.get '#/groups', ->
  @app.model.init_groups =>
    @partial('groups.haml', groups: @app.model.groups())
    
app.get '#/player', ->
  @partial('player.haml', audios: @app.model.audios()).then =>
    Player.init_play_list(@app.model.audios())

if VK?
  VK.init ->
    app.run('#/')
else
  app.run('#/')
