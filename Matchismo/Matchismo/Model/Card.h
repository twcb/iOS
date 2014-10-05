//
//  Card.h
//  Matchismo
//
//  Created by User on 10/5/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>   // old style import (backwards compatible in iOS 7)
// @import Foundation;              // new style import of an entire framework (>= iOS 7)

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
