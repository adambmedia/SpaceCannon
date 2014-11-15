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
        //InstrumentNote *note = [[InstrumentNote alloc] init];
        
        AKCrunch *crunch = [[AKCrunch alloc] initWithDuration:akp(0.1) amplitude:akp(0.9)];
        [crunch setOptionalCount:akpi(53)];
        [crunch setOptionalDampingFactor:akp(0.83)];
        [self connect:crunch];
        
        AKCompressor *compressor = [[AKCompressor alloc] initWithAffectedAudioSource:crunch
                                                              controllingAudioSource:crunch
                                                                           threshold:akp(0)
                                                                             lowKnee:akp(48)
                                                                            highKnee:akp(60)
                                                                    compressionRatio:akp(2)
                                                                          attackTime:akp(0.01)
                                                                         releaseTime:akp(0.01)];
        [self connect:compressor];
        
        AKReverb *reverb = [[AKReverb alloc] initWithAudioSource:crunch
                                                   feedbackLevel:akp(0.6)
                                                 cutoffFrequency:akp(20000)];
        [self connect:reverb];
        
        AKAudioOutput *output = [[AKAudioOutput alloc] initWithSourceStereoAudio:reverb];
        [self connect:output];
    }
    return self;
}

@end
