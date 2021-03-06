//
//  SpaceVerb.h
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/14/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "AKFoundation.h"

@interface SpaceVerb : AKInstrument

@property AKInstrumentProperty *feedbackLevel;

- (instancetype)initWithSoftBoing:(AKStereoAudio *)softBoing
                           crunch:(AKStereoAudio *)crunch
                            pluck:(AKStereoAudio *)pluck
                            laser:(AKStereoAudio *)laser
                            zwoop:(AKStereoAudio *)zwoop
                            siren:(AKStereoAudio *)siren;
@end
