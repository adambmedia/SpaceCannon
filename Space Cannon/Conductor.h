//
//  Conductor.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/8/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conductor : NSObject

- (void)haloHitEdgeAtHeight:(float)height onEdge:(NSString *)edge;

- (void)playerShotBallWithRotationVector:(CGVector)rotationVector
                            remaningAmmo:(int)remainingAmmo;

- (void)haloHitBallAtPosition:(CGPoint)position withinRectangleOfSize:(CGSize)size;

- (void)haloHitLifeBar:(float)position;

- (void)bounceOccuredOnEdge:(NSString *)edge;

- (void)shieldUp;
@end
