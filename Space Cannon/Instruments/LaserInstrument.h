//
//  LaserInstrument.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/17/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "SpatialAudioFilePlayer.h"

@interface LaserInstrument : SpatialAudioFilePlayer

@end


@interface LaserNote : SpatialAudioFilePlayerNote

- (instancetype)initWithSpeed:(float)speed pan:(float)pan;

@end
