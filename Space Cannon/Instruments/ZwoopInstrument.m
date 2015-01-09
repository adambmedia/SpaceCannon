//
//  ZwoopInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/18/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
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