//
//  CCMyScene.h
//  Space Cannon
//

//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CCMyScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) int ammo;
@property (nonatomic) int score;
@property (nonatomic) int pointValue;
@property (nonatomic) BOOL gamePaused;

@end
