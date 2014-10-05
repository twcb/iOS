//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by User on 10/5/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface MatchismoViewController ()
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *redeal;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitch;

@property (nonatomic)NSUInteger numberOfCardsToMatch;
@end

@implementation MatchismoViewController

- (NSUInteger)numberOfCardsToMatch
{
    if (!_numberOfCardsToMatch) _numberOfCardsToMatch = (unsigned long) 2;
    return _numberOfCardsToMatch;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]
                                             matching_NumberOfCards:[self numberOfCardsToMatch]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
- (IBAction)redeal:(UIButton *)sender {
    
    self.modeSwitch.enabled = YES;
    sender.enabled = NO;
    self.scoreLabel.text = @"Score: ";
    self.statusLabel.text = @"Choose a game mode!";
    self.game = nil;
    [self updateUI];
    
}
- (IBAction)modeSwitch:(UISegmentedControl *)sender {
    
    self.numberOfCardsToMatch = sender.selectedSegmentIndex + 2;
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                                matching_NumberOfCards:[self numberOfCardsToMatch]];
    NSLog(@"Game mode changed to %ld", (unsigned long)self.numberOfCardsToMatch);

}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if (self.modeSwitch.enabled){
        self.modeSwitch.enabled = NO;
        self.redeal.enabled = YES;
    }
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return (card.isChosen) ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen) ? @"cardfront" : @"cardback"];
}

@end
