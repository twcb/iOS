//
//  PlayingCard.h
//  Matchismo
//
//  Created by User on 10/5/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//


#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
