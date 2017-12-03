//
//  CALayer+OC_CALayer_Color.m
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 01/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

#import "CALayer+OC_CALayer_Color.h"

@implementation CALayer (OC_CALayer_Color)
- (void)setBorderColorWithUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}
@end
