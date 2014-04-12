//
//  CCMenu.h
//  Space Cannon
//
//  Created by Presentation on 11/03/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CCMenu : SKNode

@property (nonatomic) int score;
@property (nonatomic) int topScore;
@property (nonatomic) BOOL touchable;
@property (nonatomic) BOOL musicPlaying;
-(void)hide;
-(void)show;

@end
