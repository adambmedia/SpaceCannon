//
//  LaserInstrument.h
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/17/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "SpatialAudioFilePlayer.h"

@interface LaserInstrument : SpatialAudioFilePlayer

@end


@interface LaserNote : SpatialAudioFilePlayerNote

- (instancetype)initWithSpeed:(float)speed pan:(float)pan;

@end
