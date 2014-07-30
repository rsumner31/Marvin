//
//  NSString+Reverse.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 15/07/14.
//
//

#import "NSString+Reverse.h"

@implementation NSString (Reverse)

- (NSString *)reverse {
    NSMutableString *reversed = [NSMutableString string];
    NSInteger charIndex = [self length];

    while (charIndex > 0) {
        charIndex--;
        NSRange subRange = NSMakeRange(charIndex, 1);
        [reversed appendString:[self substringWithRange:subRange]];
    }

    return reversed;
}

@end
