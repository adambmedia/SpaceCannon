//
//  ZwoopInstrument.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/18/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "SpatialAudioFilePlayer.h"

@interface ZwoopInstrument : SpatialAudioFilePlayer

@end

@interface Zwoop : SpatialAudioFilePlayerNote

- (instancetype)initWithPan:(float)pan;

@end