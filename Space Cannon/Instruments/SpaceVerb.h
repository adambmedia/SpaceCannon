//
//  SpaceVerb.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "AKFoundation.h"

@interface SpaceVerb : AKInstrument

- (instancetype)initWithSoftBoing:(AKStereoAudio *)softBoing
                           crunch:(AKAudio *)crunch
//                       deepCrunch:(AKAudio *)deepCrunch
                             buzz:(AKStereoAudio *)buzz;
@end
