//
//  MarvinPlugIn.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 14/07/14.
//
//

#import "MarvinPlugIn.h"
#import "MarvinManager.h"

@interface MarvinPlugIn ()
@property (nonatomic, retain) MarvinManager *marvinManager;
@end

@implementation MarvinPlugIn

- (NSString *)name
{
    return MARPlugInName;
}

- (id)initWithPlugInController:(CodaPlugInsController *)aController bundle:(NSBundle*)aBundle
{
  return [self initWithController:aController];
}

- (id)initWithPlugInController:(CodaPlugInsController *)aController
                  plugInBundle:(NSObject <CodaPlugInBundle> *)plugInBundle
{
    return [self initWithController:aController];
}

- (id)initWithController:(CodaPlugInsController *)inController
{
    self = [super init];
    if (!self) return nil;

    self.marvinManager = [self.marvinManager initWithPlugInsController:inController];

    return self;
}

- (MarvinManager *)marvinManager
{
    if (_marvinManager) return _marvinManager;

    _marvinManager = [MarvinManager new];

    return _marvinManager;
}

- (void)textViewWillSave:(CodaTextView*)textView
{
    [self.marvinManager codaWillSave];
}

@end
