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

    MARMenuItem *moveToEOLandInsertTerminator = [[MARMenuItem alloc] initWithTitle:@"Move To EOL and Insert Terminator"
                                                              submenu:[self.class menuTitle]
                                                        keyEquivalent:@"~@↩"
                                                              command:^(MarvinManager *manager){
                                                                  [manager moveToEOLAndInsertTerminator];
                                                              }];
    [items addObject:moveToEOLandInsertTerminator];

    MARMenuItem *moveToEOLAndInsertTerminatorPlusLF = [[MARMenuItem alloc] initWithTitle:@"Move To EOL and Insert Terminator + LF"
                                                              submenu:[self.class menuTitle]
                                                        keyEquivalent:@"$@↩"
                                                              command:^(MarvinManager *manager){
                                                                  [manager moveToEOLAndInsertTerminatorPlusLF];
                                                              }];
    [items addObject:moveToEOLAndInsertTerminatorPlusLF];

    MARMenuItem *moveToEOLAndInsertLF = [[MARMenuItem alloc] initWithTitle:@"Move To EOL and Insert LF"
                                                              submenu:[self.class menuTitle]
                                                        keyEquivalent:@"@↩"
                                                              command:^(MarvinManager *manager){
                                                                  [manager moveToEOLAndInsertLF];
                                                              }];
    [items addObject:moveToEOLAndInsertLF];

    return [items copy];
}

+ (NSString *)menuTitle
{
    return @"Move to EOL";
}

@end
