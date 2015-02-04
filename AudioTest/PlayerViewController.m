//
//  PlayerViewController.m
//  AudioTest
//
//  Created by Benjamin McMahan on 2/3/15.
//  Copyright (c) 2015 Linked Responder. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Register to receive notification from AppDelegate when entering background
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayingAudio) name:@"stopPlayingAudio" object:nil];
    
    // Assign timer to update progress
    self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
    
    // Demo recording URL
    NSString *recordingUrl = @"https://s3.amazonaws.com/tevfd-recording/All_Fire_and_EMS_2015-02-0214_48_33_630819.mp3";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:recordingUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSLog(@"No error..");
            self.player = [[AVAudioPlayer alloc]initWithData:data error:nil];
            // Setup slider for track position
            self.slider.minimumValue = 0;
            self.slider.maximumValue = self.player.duration;
            [self.player prepareToPlay];
            [self.player play];
        }
    }]resume];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self stopPlayingAudio];
}
-(void) stopPlayingAudio {
    // Tidy things up
    [self.updateTimer invalidate];
    if ([self.player isPlaying]) {
        [self.player stop];
    }
}
- (void)updateSeekBar{
    float progress = self.player.currentTime;
    NSLog(@"progress - %f", progress);
    [self.slider setValue:progress];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
