# LastFM for Ubersicht
# Patrick Pan, patrick.pan@patrickpan.com

# Replace "your_username_here" with your username (leave the quotes)
# If you're being told to enter your username even though you already have:
# 1) You haven't scrobbled before (probably not)
# 2) Last.FM changed their API. Email me and mention Last.FM in the subject line!

command: 'username=' + 'your_username_here' + '; curl -s "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=$username&api_key=b25b959554ed76058ac220b7b2e0a026&format=json&limit=1"'

refreshFrequency: 5000

render: (output) ->
  # this is a bit of a hack until jQuery UI is included natively
  $.getScript("https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js", () ->
    $('#lastfm').draggable()
    return
  )
  # apologize for the DOM vomit here
  '<div id="lastfm"><div id="display"><div id="art"></div><div id="overart"></div><div id="text"><div><span id="timestamp"></span><br><span id="artistalbum">something\'s wrong!</span></div><div id="track"></div></div></div></div>'

afterRender: ->

update: (output) ->
  if(!output)
    return
  data = JSON.parse(output)
  if(!data.recenttracks)
    $('#track').text 'Please enter your Last.FM username in lastfm.coffee!'
    return
  track = data.recenttracks.track[0]
  if $('#track').text() != track.name
    $('#track').text track.name
    $('#track').css
      'font-size': '1rem'
      'height': 'auto'
    @autoSizeText($('#track')[0])
    $('#artistalbum').text track.artist['#text'] + ": " + track.album['#text']
    if track['@attr']
      $('#timestamp').text 'Now Playing'
    else
      $('#timestamp').text @timeString(new Date / 1000 - (track.date.uts))
    if(track.image)
      $('#art').css
        'background-image': 'url(' + track.image[track.image.length-1]['#text'] + ')'
        'background-size': 'cover'
        'background-repeat': 'no-repeat'
  return

style: """
color: #fff
#lastfm
  box-shadow: 5px 5px 25px 3px rgba(0,0,0,1)
  overflow: hidden
  position: relative
  padding-bottom: 5rem
  background: #000
  border-bottom: 1px solid #000
  border-right: 1px solid #000

#display
  padding:  0 0

#art
  width: 150px
  height: 150px
  z-index:1

#overart
  width: 150px
  height: 150px
  z-index: 2
  background-image: -webkit-gradient(
  linear, left top, left bottom, from(rgba(0,0,0,0)),
  to(rgba(0,0,0,1)), color-stop(.6,rgba(0,0,0,0.3)), color-stop(.75,rgba(0,0,0,0.6)), color-stop(.9,rgba(0,0,0,0.9)));
  position: absolute
  top:0
  left:0

#text
  position:absolute
  font-family: Helvetica Neue
  z-index:3
  bottom:0
  margin: 1rem
  text-shadow: 0 0  15px rgba(255,255,255,0.1)
  overflow-x: scroll

#artistalbum, #timestamp
  font-size: 1rem
  font-weight: 300
  width:150px
  word-wrap: break-word
  color: rgba(255,255,255,0.6)

#track
  font-size: 4rem
  font-weight: 100
  padding-right: 20px
"""

timeString: (time) ->
  if time < 60
    return 'Now Playing'
  if (time /= 60) < 1.5
    return 'A minute ago'
  if time < 59.5
    return Math.round(time, 0) + ' minutes ago'
  if (time /= 60) < 1.5
    return 'An hour ago'
  if time < 23.5
    return Math.round(time, 0) + ' hours ago'
  if (time /= 24) < 1.5
    return 'An hour ago'
  if time < 29.5
    return Math.round(time, 0) + ' days ago'
  if (time /= 30) < 1.5
    return 'A month ago'
  if time < 11.5
    return Math.round(time, 0) + ' months ago'
  return 'A long, long time ago'

autoSizeText: (el) ->
  while true
    quitme = no
    fontSize = parseInt(document.defaultView.getComputedStyle(el, null).getPropertyValue('font-size'))
    lineHeight = parseInt(document.defaultView.getComputedStyle(el, null).getPropertyValue("line-height"));
    divHeight = el.offsetHeight
    if fontSize < 25
      $(el).css
        'height': lineHeight
      return
    else
      $(el).css
        'font-size': (fontSize - 5) + "px"

    break unless divHeight > lineHeight

# ---
# generated by js2coffee 2.1.0
