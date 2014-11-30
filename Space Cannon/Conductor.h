//
//  Conductor.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/8/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conductor : NSObject

- (instancetype)initWithPlayfieldSize:(CGSize)size;
- (void)resetAll;

// Halo Lifespan Events
- (void)haloHitEdgeAtPosition:(CGPoint)position;
- (void)haloHitBallAtPosition:(CGPoint)position;
- (void)haloHitShieldAtPosition:(CGPoint)position;
- (void)haloHitLifeBar;

// Shield Power Up Events
- (void)spawnedShieldPowerUpAtPosition:(CGPoint)position;
- (void)updateShieldPowerUpPosition:(CGPoint)position;
- (void)replacedShieldAtPosition:(CGPoint)position;

// Player Events
- (void)playerShotBallWithRotationVector:(CGVector)rotationVector
                            remaningAmmo:(int)remainingAmmo;
- (void)attemptedShotWithoutAmmo;
- (void)ballBouncedAtPosition:(CGPoint)position;
- (void)multiplierModeStartedWithPointValue:(int)points;
- (void)multiplierModeEnded;


@end
