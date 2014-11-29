//
//  SpaceVerb.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "AKFoundation.h"

@interface SpaceVerb : AKInstrument

@property AKInstrumentProperty *feedbackLevel;

- (instancetype)initWithSoftBoing:(AKStereoAudio *)softBoing
                           crunch:(AKAudio *)crunch
                            pluck:(AKStereoAudio *)pluck
                            laser:(AKStereoAudio *)laser
                            zwoop:(AKStereoAudio *)zwoop
                            siren:(AKStereoAudio *)siren
                           menace:(AKStereoAudio *)menace;
@end
