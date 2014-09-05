//
//  StatView.m
//  CoreImageVideoTestbed
//
//  Created by Joshua Sullivan on 9/4/14.
//  Copyright (c) 2014 Joshua Sullivan. All rights reserved.
//

#import "StatView.h"

static const NSUInteger kTimingsToKeep = 30;

@interface StatView ()

@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;

@property (strong, nonatomic) NSMutableArray *timingsArray;

@end

@implementation StatView

- (void)awakeFromNib
{
    self.timingsArray = [NSMutableArray arrayWithCapacity:kTimingsToKeep + 1];
}

- (void)addTiming:(NSTimeInterval)timing
{
    [self.timingsArray addObject:@(timing)];
    if ([self.timingsArray count] > kTimingsToKeep) {
        [self.timingsArray removeObjectAtIndex:0];
    }

    NSNumber *min = [self.timingsArray valueForKeyPath:@"@min.self"];
    NSNumber *avg = [self.timingsArray valueForKeyPath:@"@avg.self"];
    NSNumber *max = [self.timingsArray valueForKeyPath:@"@max.self"];
    self.minLabel.text = [NSString stringWithFormat:@"Min: %0.2f", [min floatValue]];
    self.avgLabel.text = [NSString stringWithFormat:@"Avg: %0.2f", [avg floatValue]];
    self.maxLabel.text = [NSString stringWithFormat:@"Max: %0.2f", [max floatValue]];
}

- (void)resetStats
{
    [self.timingsArray removeAllObjects];
}


@end
