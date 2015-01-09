//
//  PluckyInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/29/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
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
        
        NSString *file;
        file = [[NSBundle mainBundle] pathForResource:@"marmstk1" ofType:@"wav"];
        
        AKSoundFile *soundFile = [[AKSoundFile alloc] initWithFilename:file];
        [self addFunctionTable:soundFile];
        
        AKMonoSoundFileLooper *impulse = [AKMonoSoundFileLooper looperWithSoundFile:soundFile];
        impulse.loopMode = AKSoundFileLooperModeNoLoop;
        [self connect:impulse];
        
        // Instrument Definition
        AKPluckedString *pluck = [AKPluckedString pluckWithExcitationSignal:impulse];
        pluck.frequency = note.frequency;
        [pluck setOptionalAmplitude:akp(0.15)];
        [pluck setOptionalReflectionCoefficient:akp(0.2)];
        [self connect:pluck];
        
        AKPanner *panner = [[AKPanner alloc] initWithInput:pluck pan:note.pan panMethod:AKPanMethodEqualPower];
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
