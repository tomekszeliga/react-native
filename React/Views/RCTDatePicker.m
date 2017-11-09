/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "RCTDatePicker.h"

#import "RCTUtils.h"
#import "UIView+React.h"

@interface RCTDatePicker ()

@property (nonatomic, copy) RCTBubblingEventBlock onChange;

@end

@implementation RCTDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    [self addTarget:self action:@selector(didChange)
               forControlEvents:UIControlEventValueChanged];
  }
  return self;
}

RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)

- (void)didChange
{
  if (_onChange) {
      // Use a weak reference to `self` to avoid a retain cycle.
      __weak __typeof__(self) weakSelf = self;
      dispatch_async(dispatch_get_main_queue(), ^{
        _onChange(@{ @"timestamp": @(weakSelf.date.timeIntervalSince1970 * 1000.0)});
      });
    }
}

@end
