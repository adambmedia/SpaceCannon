//
//  CrunchInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "CrunchInstrument.h"

@implementation CrunchInstrument
- (instancetype)init
{
    self = [super init];
    if (self) {
        Crunch *note = [[Crunch alloc] init];
        [self addNoteProperty:note.count];
        [self addNoteProperty:note.damping];
        [self addNoteProperty:note.pan];
        
        AKCrunch *crunch = [[AKCrunch alloc] initWithDuration:akp(0.1) amplitude:akp(0.9)];
        [crunch setOptionalCount:note.count];
        [crunch setOptionalDampingFactor:note.damping];
        [self connect:crunch];
        
        
        AKLowPassButterworthFilter *lowPassFilter;
        lowPassFilter = [[AKLowPassButterworthFilter alloc] initWithAudioSource:crunch cutoffFrequency:akp(1200)];
        [self connect:lowPassFilter];
        
        
        _auxilliaryOutput = [AKAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:lowPassFilter];
    }
    return self;
}

@end



@implementation Crunch

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _count = [[AKNoteProperty alloc] initWithValue:53 minimum:53 maximum:153];
        [self addProperty:_damping];
        
        _damping = [[AKNoteProperty alloc] initWithValue:0.63 minimum:0.43 maximum:0.83];
        [self addProperty:_damping];
        
        _pan = [[AKNoteProperty alloc] initWithValue:0.5 minimum:0 maximum:1];
        [self addProperty:_pan];
        
    }
    return self;
}



- (instancetype)initWithCount:(float)count damping:(float)damping pan:(float)pan
{
    self = [self init];
    if (self) {
        _pan.value = pan;
    }
    return self;
}


- (instancetype)initAsDeepCrunch
{
    return [self initWithCount:153
                       damping:0.83
                           pan:0.5];
}

@end