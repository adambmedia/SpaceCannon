//
//  PluckyInstrument.h
//  Space Cannon
//
//  Created by Nicholas Arner on 11/29/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "AKFoundation.h"

@interface PluckyInstrument : AKInstrument

// Audio outlet for global effects processing
@property (readonly) AKStereoAudio *auxilliaryOutput;

@end

@interface Pluck : AKNote

// Note properties
@property AKNoteProperty *frequency;
@property AKNoteProperty *pan;
- (instancetype)initWithFrequency:(float)frequency pan:(float)pan;

@end
