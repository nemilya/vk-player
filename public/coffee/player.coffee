class Player
  @init_play_list: (play_list) ->
    console.log $('#jquery_jplayer_1')
    config = 
      jPlayer: "#jquery_jplayer_1"
      cssSelectorAncestor: "#jp_container_1"

    params = 
      playlistOptions:
        autoPlay: true
      swfPath: "js",
      supplied: "mp3",
      wmode: "window"

    new jPlayerPlaylist(config, play_list, params)

root = this ? this : exports
root.Player = Player