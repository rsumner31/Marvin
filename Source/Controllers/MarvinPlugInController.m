//
//  MarvinPlugIn.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 14/07/14.
//
//

#import "MarvinPlugInController.h"

@implementation MarvinPlugInController

- (NSString *)name
{
    return @"Marvin";
}

- (id)initWithPlugInController:(CodaPlugInsController*)aController bundle:(NSBundle*)aBundle
{
  return [self initWithController:aController];
}

- (id)initWithPlugInController:(CodaPlugInsController*)aController
                  plugInBundle:(NSObject <CodaPlugInBundle> *)plugInBundle
{
    return [self initWithController:aController];
}

- (id)initWithController:(CodaPlugInsController*)inController
{
    self = [super init];
    if (!self) return nil;

    return self;
}

@end
