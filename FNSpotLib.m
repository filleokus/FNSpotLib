//
//  FNSpotLib.m
//  FNSpotLIb
//
//  Created by Filip Nilsson on 2013-01-01.
//  Copyright (c) 2013 Filip Nilsson. All rights reserved.
//

#import "FNSpotLib.h"
#import "FNSpotTrack.h"
#import <ScriptingBridge/ScriptingBridge.h>
#import "Spotify.h"


@interface FNSpotLib ()
@property (strong) SpotifyApplication *spotify;
@end


@implementation FNSpotLib

-(instancetype)init {
    if (!(self = [super init]))
        return nil;
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateHasChanged:) name:@"com.spotify.client.PlaybackStateChanged" object:nil suspensionBehavior:NSNotificationSuspensionBehaviorHold];
    return self;
}

-(void)playbackStateHasChanged:(NSNotification*)notification {
    [self willChangeValueForKey:@"currentTrack"];
    [self didChangeValueForKey:@"currentTrack"];
    [self willChangeValueForKey:@"playerState"];
    [self didChangeValueForKey:@"playerState"];
}

+ (instancetype)spotify {
    FNSpotLib *spotLib = [[FNSpotLib alloc] init];
    spotLib.spotify = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    return spotLib;
}

#pragma mark - Properties

-(FNSpotTrack*)currentTrack {
    return [[FNSpotTrack alloc] initWithSpotifyTrack:self.spotify.currentTrack];
}

- (void)setSoundVolume:(NSUInteger)soundVolume {
    self.spotify.soundVolume = soundVolume;
}

- (void)setPlayerPosition:(NSTimeInterval)playerPosition {
    self.spotify.playerPosition = playerPosition;
}

- (void)setRepeating:(BOOL)repeating {
    self.spotify.repeating = repeating;
}

- (void)setShuffling:(BOOL)shuffling {
    self.spotify.shuffling = shuffling;
}

-(NSUInteger)soundVolume {
    return self.spotify.soundVolume;
}

-(NSTimeInterval)playerPosition {
    return self.spotify.playerPosition;
}

-(SpotifyPlayerState)playerState {
    switch (self.spotify.playerState) {
        case SpotifyEPlSPaused:
            return SpotifyPaused;
        case SpotifyEPlSPlaying:
            return SpotifyPlaying;
        case SpotifyEPlSStopped:
            return SpotifyStopped;
    }
}

-(BOOL)isRepeating {
    return self.spotify.repeating;
}

-(BOOL)isShuffling {
    return self.spotify.shuffling;
}

#pragma mark - Playback

-(void)nextTrack {
    [self.spotify nextTrack];
}
-(void)previousTrack {
    [self.spotify previousTrack];
}
-(void)playPause {
    [self.spotify playpause];
}
-(void)play {
    [self.spotify play];
}

-(void)playTrack:(NSURL*)trackURL inContext:(NSURL*)contextURL {
    trackURL = [self SpotifyURIFromURL:trackURL];
    contextURL = [self SpotifyURIFromURL:contextURL];
    [self.spotify playTrack:trackURL.absoluteString inContext:contextURL.absoluteString];
}

-(void)pause {
    [self.spotify pause];
}

#pragma mark - Convinence methods

-(NSURL*)SpotifyURIFromURL:(NSURL*)URL {
    if ([URL.scheme isEqualToString:@"spotify"])
        return URL;
    if ([URL.host isEqualToString:@"open.spotify.com"]) {
        NSArray *pathComponents = URL.pathComponents;
        NSString *URIString = [NSString stringWithFormat:@"spotify:%@",[[pathComponents subarrayWithRange:NSMakeRange(1, pathComponents.count-1)] componentsJoinedByString:@":"]];
        return [NSURL URLWithString:URIString];
    }
    else
        return nil;
    
}

- (void)setSoundVolume:(NSUInteger)soundVolume fadeDuration:(NSUInteger)seconds {
    NSUInteger currentVolume = self.spotify.soundVolume;
    NSUInteger volumeDistance = abs((int)currentVolume-(int)soundVolume);
    double multiplier;
    if (currentVolume < soundVolume) {
        multiplier = volumeDistance/100.0;
    }
    else {
        multiplier = -(volumeDistance/100.0);
    }
    
    useconds_t sleepStep = (seconds / 100.0) * USEC_PER_SEC;
    for(NSInteger i=0; i<=100; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSUInteger volume = currentVolume+multiplier*i;
            self.spotify.soundVolume = volume;
            usleep(sleepStep);
        });
    }
}


@end
