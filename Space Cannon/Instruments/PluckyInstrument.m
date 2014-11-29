//
//  PluckyInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/29/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "PluckyInstrument.h"

@implementation PluckyInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Note Properties
        Pluck *note = [[Pluck alloc] init];
        [self addNoteProperty:note.frequency];
        [self addNoteProperty:note.pan];
        
        AKLinearControl *decay = [[AKLinearControl alloc] initFromValue:akp(1)
                                                                toValue:akp(0)
                                                               duration:akp(0.5)];
        [self connect:decay];
        
        AKOscillator *osc =[[AKOscillator alloc] initWithFTable:[AKManager sharedAKManager].standardSineTable
                                                      frequency:akp(1)
                                                      amplitude:decay];
        [self connect:osc];
        
        // Instrument Definition
        AKPluckedString *pluck = [AKPluckedString audioWithExcitationSignal:osc];
        pluck.frequency = note.frequency;
        [pluck setOptionalAmplitude:akp(0.3)];
        [pluck setOptionalReflectionCoefficient:akp(0.2)];
        [self connect:pluck];
        
        AKPanner *panner = [[AKPanner alloc] initWithAudioSource:pluck pan:note.pan];
        [self connect:panner];
        
        // Output to global effects processing
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:panner];
    }
    return self;
}
@end

// -----------------------------------------------------------------------------
#  pragma mark - PluckyInstrument Note
// -----------------------------------------------------------------------------


@implementation Pluck

- (instancetype)init
{
    self = [super init];
    if (self) {
        _frequency = [[AKNoteProperty alloc] initWithValue:440 minimum:100 maximum:20000];
        [self addProperty:_frequency];
        
        _pan = [[AKNoteProperty alloc] initWithValue:0.0 minimum:0 maximum:1];
        [self addProperty:_pan];
        
        // Optionally set a default note duration
        self.duration.value = 1;
    }
    return self;
}

- (instancetype)initWithFrequency:(float)frequency pan:(float)pan;
{
    self = [self init];
    if (self) {
        _frequency.value = frequency;
        _pan.value = pan;
    }
    return self;
}

@end
