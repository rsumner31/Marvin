//
//  MARMenuItem.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 14/07/14.
//
//

#import "MARMenuItem.h"

@implementation MARMenuItem

- (instancetype)initWithTitle:(NSString *)title submenu:(NSString *)submenu keyEquivalent:(NSString *)binding command:(void (^)(MarvinManager *manager))command
{
    self = [super init];
    if (!self) return nil;
    
    self.title = title;
    self.submenu = submenu;
    self.keyEquivalent = binding;
    self.command = command;
    
    return self;
}

+ (NSArray *)items
{
    return nil;
}

@end
