//
//  FNSpotLib.h
//  FNSpotLIb
//
//  Created by Filip Nilsson on 2013-01-01.
//  Copyright (c) 2013 Filip Nilsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNSpotTrack.h"

typedef enum  {
	SpotifyStopped,
	SpotifyPlaying,
	SpotifyPaused
}SpotifyPlayerState;

@interface FNSpotLib : NSObject
@property (readonly, strong) FNSpotTrack *currentTrack;
@property (readwrite) NSUInteger soundVolume; // The volume is given between 0 and 100
@property (readonly) SpotifyPlayerState playerState;
@property (readwrite) NSTimeInterval playerPosition;
@property (readwrite, getter=isRepeating) BOOL repeating;
@property (readwrite, getter=isShuffling) BOOL shuffling;

+ (instancetype)spotify;

-(void)nextTrack;
-(void)previousTrack;
-(void)playPause;
-(void)play;
-(void)playTrack:(NSURL*)trackURL inContext:(NSURL*)contextURL; // This methods accepts both Spotify URIs and URLs as trackURL
-(void)pause;

- (void)setSoundVolume:(NSUInteger)soundVolume fadeDuration:(NSUInteger)seconds;
@end
