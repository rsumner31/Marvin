//
//  MARObjectiveCMenu.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 30/07/14.
//
//

#import "MARObjectiveCMenu.h"

@implementation MARObjectiveCMenu

+ (NSArray *)items
{
    NSMutableArray *items = [NSMutableArray array];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Open Counterpart" submenu:[self.class menuTitle] keyEquivalent:@"$@c" command:^(MarvinManager *manager){
            [manager openCounterpart];
        }];
        menuItem;
    })];

    return [items copy];
}

+ (NSString *)menuTitle
{
    return @"Objective-C";
}

@end
