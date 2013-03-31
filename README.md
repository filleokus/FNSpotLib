FNSpotLib
=========

Simple Objective-C wrapper for Spotify's AppleScript API. See the included example project.



Usage
-----
Initilaize FNSpotLib by calling `spotify` and store the object for later use.
```objc
self.spotLib = [FNSpotLib spotify];
```
Notifcations and support for NSObject methods
---------------------------------------------
`FNSpotlib` issues a `NSNotifaction` when the playback state has changed. This can be useful to for example update the cover art and track information:
```objc
[self.spotLib addObserver:self keyPath:@"currentTrack" options:0 block:^(MAKVONotification *notification) {
    self.trackField.stringValue = self.spotLib.currentTrack.description;
    self.coverArtImageCell.image = self.spotLib.currentTrack.artwork;
}];
```
`FNSpotlib` supports the conventions of `NSObject` and instances of `FNSpotTrack` can thus be compared, hashed, and has a description.


Control playback
-----
### -nextTrack()
Skip to the next track.

### -previousTrack()
Skip to the previous track.

### -playPause()
Toggle between play and pause.

### -play()
Play playback.

### -pause()
Pause playback.

### -playTrack:(NSURL *) inContext:(NSURL *)
Start playback of given track in given context, i.e a certain track within a playlist. This method accept both Spotify
URIs aswell as URLs.

### - (void)setSoundVolume:(NSUInteger) fadeDuration:(NSUInteger)
Set the sound volume with a fade.

Player information
------------------
The following properties on the main object gives access to information about the player:

### soundVolume
Settable sound volume from 0-100. `NSUInteger`

### repeating
Settable state of repeating. `BOOL`

### playerPosition
Settable player position `NSTimeInterval`

### playerState
The player state:
 * `SpotifyPaused` The player is paused.
 * `SpotifyPlaying` The player is playing.
 * `SpotifyStopped` The player is stopped, i.e no tracks are queed.  

Current track information
----------------------

The current track is represented as an `FNSpotTrack` property on the main object. `FNSpotTrack` has the
properties:

### artist
The artist of the track. `NSString`

### album
The album of the track. `NSString`

### discNumber
The discnumber of the track. `NSString`

### duration
The duration of the track in seconds. `NSString`

### playedCount
The number of times this track has been played on the current account. `NSUInteger`

### trackNumber
The index number the track in its album. `NSUInteger`

### starred
Wether the track is starred or not. `BOOL`

### ID
The internal Spotify ID of the track. `NSString`

### name
The name of the track. `NSString`

### artwork
The cover for the track's album. `NSImage`

### albumArtist
The album artist of the track. `NSString`

### URL
The Spotify URL for the track.`NSURL`

### popularity
The popularity of the track from 0-100. `NSUInteger`
