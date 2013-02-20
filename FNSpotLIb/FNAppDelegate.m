//
//  FNAppDelegate.m
//  FNSpotLIb
//
//  Created by Filip Nilsson on 2013-01-01.
//  Copyright (c) 2013 Filip Nilsson. All rights reserved.
//

#import "FNAppDelegate.h"
#import "FNSpotLib.h"
#import "MAKVONotificationCenter.h"
@interface FNAppDelegate()
@property (weak) IBOutlet NSTextField *trackField;
@property (weak) IBOutlet NSImageCell *coverArtImageCell;
@property (strong) FNSpotLib *spotLib;
@end

@implementation FNAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.spotLib = [FNSpotLib spotify];
    [self.spotLib addObserver:self keyPath:@"currentTrack" options:0 block:^(MAKVONotification *notification) {
        self.trackField.stringValue = self.spotLib.currentTrack.description;
        self.coverArtImageCell.image = self.spotLib.currentTrack.artwork;
    }];
    [self.spotLib setSoundVolume:30];
    [self.spotLib setShuffling:YES];
    [self.spotLib playTrack:[NSURL URLWithString:@"spotify:track:1qrHkGZCxZqFqsHvq7AwqU"] inContext:[NSURL URLWithString:@"http://open.spotify.com/user/simonb/playlist/7IRzLnKfOhuLQMsgcwJ3Bb"]];
    
}

- (IBAction)play:(id)sender {
    [self.spotLib play];
}
- (IBAction)pause:(id)sender {
    [self.spotLib pause];
}
- (IBAction)nextTrack:(id)sender {
    [self.spotLib nextTrack];
}
-(IBAction)previousTrack:(id)sender {
    [self.spotLib previousTrack];
}

@end
