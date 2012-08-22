window.app = $.sammy ->
  @element_selector = '#content'
  @use(Sammy.Haml, 'haml')

model = new Model

app.get '#/', (context) ->
  context.app.swap('Hello!')
  if model.is_group_configured()
    context.redirect('#/player')
  else
    context.redirect('#/groups')

app.get '#/set_group', (context) ->
  model.set_gid @params.gid
  context.redirect '#/'

app.get '#/groups', (context) ->
  groups = model.groups()
  context.partial('/templates/groups.haml', groups: groups)

app.get '#/player', (context) ->
  audios = model.audios()
  context.partial('/templates/player.haml', audios: audios)

$ ->
  app.run('#/')



