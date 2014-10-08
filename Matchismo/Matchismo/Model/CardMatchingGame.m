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
@property (nonatomic) NSUInteger gameType;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableString *)status
{
    if (!_status) _status = [[NSMutableString stringWithString:@"Pick a card"] init];
    return _status;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
           matching_NumberOfCards:(NSUInteger)numberOfCardsToMatch;

{
    self = [super init];
    self.gameType = numberOfCardsToMatch;
    
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
    
    //NSLog(@"The value of status is now %@", self.status);
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    NSLog(@"The value of status is now %@", self.status);
    
    Card *card = [self cardAtIndex:index];
    
        if (!card.isMatched) {
        
        if (card.isChosen) {
            
            card.chosen = NO;
            
        } else {
            
            [self.status setString:[NSMutableString stringWithFormat:@"Matching %@ ,",card.contents]];
            NSLog(@"The value of status is now %@", self.status);
            //if(self.gameType == 3){}
            
                        // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    [self.status setString:[NSMutableString stringWithFormat:@"%@ %@",self.status,otherCard.contents]];
                    NSLog(@"The value of status is now %@", self.status);
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        // increase score
                        self.score += (matchScore * MATCH_BONUS);
                        //inform user
                        [self.status setString:[NSMutableString stringWithFormat:@"%@ matched %@. %d points earned",card.contents,otherCard.contents, (matchScore * MATCH_BONUS)]];
                        // mark cards as matched
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        // mismath penalty when cards do no match
                        self.score -= MISMATCH_PENALTY;
                        
                        [self.status setString:[NSMutableString stringWithFormat:@"%@ did not match %@. You lost %d points",card.contents,otherCard.contents, MISMATCH_PENALTY]];

                        
                        // flip othercard
                        otherCard.chosen = NO;
                    }
                    
                    break;
                }
            }
            
            
            
            //[self.status setString:@"Pick a card"];
            NSLog(@"The value of status is now %@", self.status);

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
