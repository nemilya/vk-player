class Player
  @init_play_list: (play_list) ->
    config = 
      jPlayer: "#jquery_jplayer_1"
      cssSelectorAncestor: "#jp_container_1"

    params = 
      playlistOptions:
        autoPlay: true
      supplied: "mp3",
      swfPath: "/assets/js",
      wmode: "window"

    new jPlayerPlaylist(config, play_list, params)

root = this ? this : exports
root.Player = Player