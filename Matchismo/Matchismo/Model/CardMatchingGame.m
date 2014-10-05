//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by User on 10/5/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;    // make score writable in out private API
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) NSMutableString *status; //follows the algorithm for the game through user phrased output
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
           matching_NumberOfCards:(NSUInteger)numberOfCardsToMatch;

{
    self = [super init];
    
    if (self) {
        for (NSUInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        
        if (card.isChosen) {
            
            card.chosen = NO;
            
        } else {
                        // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [self.status stringByAppendingString:@""];
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        // increase score
                        self.score += (matchScore * MATCH_BONUS);
                        
                        // mark cards as matched
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        // mismath penalty when cards do no match
                        self.score -= MISMATCH_PENALTY;
                        
                        // flip othercard
                        otherCard.chosen = NO;
                    }
                    
                    break;
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
