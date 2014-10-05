//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by User on 10/5/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                
                // add card
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end

