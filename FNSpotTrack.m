//
//  FNSpotTrack.m
//  FNSpotLIb
//
//  Created by Filip Nilsson on 2013-01-02.
//  Copyright (c) 2013 Filip Nilsson. All rights reserved.
//

#import "FNSpotTrack.h"
#import "Spotify.h"
@interface FNSpotTrack ()
@property (readwrite, copy) NSString *artist;
@property (readwrite, copy) NSString *album;
@property (readwrite) NSUInteger discNumber;
@property (readwrite) NSTimeInterval duration;
@property (readwrite) NSUInteger playedCount;
@property (readwrite) NSUInteger trackNumber;
@property (readwrite, getter=isStarred) BOOL starred;
@property (readwrite, copy) NSString *ID;
@property (readwrite, copy) NSString *name;
@property (readwrite, copy) NSImage *artwork;
@property (readwrite, copy) NSString *albumArtist;
@property (readwrite, copy) NSURL *URL;
@property (readwrite) NSUInteger popularity;
@end
@implementation FNSpotTrack

-(id)initWithSpotifyTrack:(SpotifyTrack*)spotifyTrack {
    if(!(self = [super init]))
        return nil;
    self.artist = spotifyTrack.artist;
    self.album = spotifyTrack.album;
    self.discNumber = spotifyTrack.discNumber;
    self.duration = spotifyTrack.duration;
    self.playedCount = spotifyTrack.playedCount;
    self.trackNumber = spotifyTrack.trackNumber;
    self.starred = spotifyTrack.starred;
    self.ID = spotifyTrack.id;
    self.name = spotifyTrack.name;
    self.artwork = spotifyTrack.artwork;
    self.albumArtist = spotifyTrack.albumArtist;
    self.popularity = spotifyTrack.popularity;
    self.URL = [NSURL URLWithString:spotifyTrack.spotifyUrl];
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ - %@",self.name,self.artist];
}

-(BOOL)isEqual:(id)object {
    if ([object isKindOfClass:self.class]) {
        return [self.ID isEqual:[object ID]];
    }
    return NO;
}

-(NSUInteger)hash {
    NSString *hashSubstring = [self.ID substringToIndex:sizeof(uint64_t)];
    NSData *buffer = [hashSubstring dataUsingEncoding:NSUTF8StringEncoding];
    return *(uint64_t*)buffer.bytes;
}


@end
