//
//  FNSpotTrack.h
//  FNSpotLIb
//
//  Created by Filip Nilsson on 2013-01-02.
//  Copyright (c) 2013 Filip Nilsson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SpotifyTrack;

@interface FNSpotTrack : NSObject
-(id)initWithSpotifyTrack:(SpotifyTrack*)spotifyTrack;
@property (readonly, copy) NSString *artist;
@property (readonly, copy) NSString *album;
@property (readonly) NSUInteger discNumber;
@property (readonly) NSTimeInterval duration;
@property (readonly) NSUInteger playedCount;
@property (readonly) NSUInteger trackNumber;
@property (readonly, getter=isStarred) BOOL starred;
@property (readonly, copy) NSString *ID;
@property (readonly, copy) NSString *name;
@property (readonly, copy) NSImage *artwork;
@property (readonly, copy) NSString *albumArtist;
@property (readonly) NSUInteger popularity;
@property (readonly, copy) NSURL *URL;
@end
