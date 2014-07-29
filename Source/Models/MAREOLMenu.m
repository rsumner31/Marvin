//
//  MAREOLMenu.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 23/07/14.
//
//

#import "MAREOLMenu.h"

@implementation MAREOLMenu

+ (NSArray *)items
{
    NSMutableArray *items = [NSMutableArray array];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Move To EOL and Insert Terminator"
                                                              submenu:[self.class menuTitle]
                                                        keyEquivalent:@"~@↩"
                                                              command:^(MarvinManager *manager){
                                                                  [manager moveToEOLAndInsertTerminator];
                                                              }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Move To EOL and Insert Terminator + LF"
                                                              submenu:[self.class menuTitle]
                                                        keyEquivalent:@"$@↩"
                                                              command:^(MarvinManager *manager){
                                                                  [manager moveToEOLAndInsertTerminatorPlusLF];
                                                              }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Move To EOL and Insert LF"
                                                              submenu:[self.class menuTitle]
                                                        keyEquivalent:@"@↩"
                                                              command:^(MarvinManager *manager){
                                                                  [manager moveToEOLAndInsertLF];
                                                              }];
        menuItem;
    })];

    return [items copy];
}

+ (NSString *)menuTitle
{
    return @"Move to EOL";
}

@end
