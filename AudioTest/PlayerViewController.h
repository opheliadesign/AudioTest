//
//  PlayerViewController.h
//  AudioTest
//
//  Created by Benjamin McMahan on 2/3/15.
//  Copyright (c) 2015 Linked Responder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface PlayerViewController : UIViewController
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) NSTimer *updateTimer;
@property (strong, nonatomic) IBOutlet UISlider *slider;
- (IBAction)seek:(id)sender;
@end
