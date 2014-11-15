//
//  Conductor.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/8/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conductor : NSObject

- (void)haloHitLeftEdgeAtPosition:(float)position;
- (void)haloHitRightEdgeAtPosition:(float)position;

- (void)playerShotBallWithRotationVector:(CGVector)rotationVector
                            remaningAmmo:(int)remainingAmmo;

- (void)haloHitBall:(float)position;
- (void)haloHitLifeBar:(float)position;

- (void)bounceOccured;
- (void)shieldUp;
@end
