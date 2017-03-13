//
//  APPDetailViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPDetailViewController.h"

@interface APPDetailViewController ()

@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (strong, nonatomic) UITextView *translatedView;
@property (strong, nonatomic) UITextView *paliView;
@property (strong, nonatomic) UITextView *sourceView;
@property (strong, nonatomic) UILabel *WORDS;
@property (strong, nonatomic) UILabel *MEANING;
@property (nonatomic, strong) UIButton *play;

@end

@implementation APPDetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.paliView];
    [self.contentScrollView addSubview:self.translatedView];
    [self.contentScrollView addSubview:self.sourceView];
    [self.contentScrollView addSubview:self.WORDS];
    [self.contentScrollView addSubview:self.MEANING];
    [self.contentScrollView addSubview:self.play];    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.controller.player pause];
}

- (void)setTranslated:(NSString *)translated {
    if (![_translated isEqualToString:translated]) {
        _translated = translated;
        self.translatedView.text = _translated;
        self.translatedView.frame = CGRectMake(15, _MEANING.frame.origin.y + _MEANING.frame.size.height, 290, 667);
        CGSize size2 = [self.translatedView sizeThatFits:CGSizeMake(self.translatedView.frame.size.width, CGFLOAT_MAX)];
        self.sourceView.frame = CGRectMake(0, self.translatedView.frame.origin.y + size2.height + 5, 320, 60);
        [self.contentScrollView setContentSize:CGSizeMake(320, self.sourceView.frame.origin.y + 60 + 44)];
    }
}

- (void)setPali:(NSString *)pali {
    if (![_pali isEqualToString:pali]) {
        _pali = pali;
        self.paliView.text = _pali;
        
        // adjust origin y of the rest of the views
        CGSize size = [self.paliView sizeThatFits:CGSizeMake(self.paliView.frame.size.width, CGFLOAT_MAX)];
        self.play.frame = CGRectMake((self.view.frame.size.width - 44)/2, self.paliView.frame.origin.y + size.height + 5, 44, 80);
        self.MEANING.frame = CGRectMake(0, self.play.frame.origin.y + self.play.frame.size.height + 20, 320, 20);
    }
}

- (void)setSource:(NSString *)source {
    if (![_source isEqualToString:source]) {
        _source = source;
        self.sourceView.text = _source;
    }
}

- (void)setListen_link:(NSString *)listen_link {
    if (![_listen_link isEqualToString:listen_link]) {
        _listen_link = listen_link;
        
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [detector matchesInString:_listen_link options:0 range:NSMakeRange(0, [_listen_link length])];
        
        if ([matches count] > 0) {
            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[matches[0] URL]];
            AVPlayer* player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
            self.controller.player = player;
        }
    }
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        [_contentScrollView setBackgroundColor:[UIColor redColor]];
    }
    return _contentScrollView;
}

- (UITextView *)paliView {
    if (!_paliView) {
        _paliView = [[UITextView alloc] initWithFrame:CGRectMake(15, 50, 290, 667)];
        [_paliView setUserInteractionEnabled:NO];
        [_paliView setTextColor:[UIColor blackColor]];
        [_paliView setTextAlignment:NSTextAlignmentCenter];
        [_paliView setFont:[UIFont fontWithName:@"Baskerville" size:19]];
    }
    return _paliView;
}

- (UITextView *)translatedView {
    if (!_translatedView) {
        _translatedView = [[UITextView alloc] initWithFrame:CGRectMake(15, 300, 290, 667)];
        [_translatedView setUserInteractionEnabled:NO];
        [_translatedView setTextColor:[UIColor blackColor]];
        [_translatedView setTextAlignment:NSTextAlignmentCenter];
        [_translatedView setFont:[UIFont fontWithName:@"Baskerville" size:19]];
    }
    return _translatedView;
}

- (UITextView *)sourceView {
    if (!_sourceView) {
        _sourceView = [[UITextView alloc] initWithFrame:CGRectMake(0, 500, 320, 60)];
        [_sourceView setUserInteractionEnabled:NO];
        [_sourceView setTextColor:[UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f]];
        [_sourceView setTextAlignment:NSTextAlignmentCenter];
        [_sourceView setFont:[UIFont fontWithName:@"LucidaGrande" size:10]];
    }
    return _sourceView;
}

- (UIButton *)play {
    if (!_play) {
        _play = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_play setImage:[UIImage imageNamed:@"audio@2x.png"] forState:UIControlStateNormal];
        [_play setEnabled:YES];
        [_play addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _play;
}

- (UILabel *)WORDS {
    if (!_WORDS ) {
        _WORDS = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 20)];
        [_WORDS setTextColor:[UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f]];
        [_WORDS setTextAlignment:NSTextAlignmentCenter];
        [_WORDS setFont:[UIFont fontWithName:@"LucidaGrande" size:10]];
        _WORDS.text = @"WORDS";
    }
    return _WORDS;
}

- (UILabel *)MEANING {
    if (!_MEANING ) {
        _MEANING = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 320, 20)];
        [_MEANING setTextColor:[UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f]];
        [_MEANING setTextAlignment:NSTextAlignmentCenter];
        [_MEANING setFont:[UIFont fontWithName:@"LucidaGrande" size:10]];
        _MEANING.text = @"MEANING";
    }
    return _MEANING;
}

- (AVPlayerViewController *)controller {
    if (!_controller) {
        NSError *_error = nil;
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &_error];
        _controller = [[AVPlayerViewController alloc] init];
        [_controller setShowsPlaybackControls:NO];
        _controller.view.layer.borderWidth = 1;
        _controller.view.layer.borderColor = [[UIColor redColor]CGColor];
    }
    return _controller;
}

- (void)playButtonTapped:(UIButton *)button {
    if (self.controller.player.rate == 0) {
        [self.controller.player play];
    }
}

@end
