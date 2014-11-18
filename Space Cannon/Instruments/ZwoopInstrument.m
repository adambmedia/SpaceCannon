//
//  ZwoopInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/18/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "ZwoopInstrument.h"

@implementation ZwoopInstrument

- (instancetype)init {
    return [super initWithFilename:@"ShieldUp"];
}

@end

@implementation Zwoop

- (instancetype)initWithPan:(float)pan {
    self = [super init];
    if(self) {
        self.pan.value = pan;
    }
    return self;
}

@end