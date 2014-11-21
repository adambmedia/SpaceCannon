//
//  BuzzInstrument.h
//  Space Cannon
//
//  Created by Nicholas Arner on 11/14/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "AKFoundation.h"

@interface BuzzInstrument : AKInstrument

@property (readonly) AKStereoAudio *auxilliaryOutput;

@end

@interface Buzz : AKNote
@property AKNoteProperty *frequency;
@property AKNoteProperty *amplitude;
@property AKNoteProperty *pressure;
@property AKNoteProperty *pan;

- (instancetype)initWithFrequency:(float)frequency amplitude:(float)amplitude pan:(float)pan;

@end