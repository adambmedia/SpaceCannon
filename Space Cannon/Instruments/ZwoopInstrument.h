//
//  ZwoopInstrument.h
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/18/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "SpatialAudioFilePlayer.h"

@interface ZwoopInstrument : SpatialAudioFilePlayer

@end

@interface Zwoop : SpatialAudioFilePlayerNote

- (instancetype)initWithPan:(float)pan;

@end