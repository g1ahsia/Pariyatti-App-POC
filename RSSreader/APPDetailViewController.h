//
//  APPDetailViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVKit;
@import AVFoundation;

@interface APPDetailViewController : UIViewController

@property (copy, nonatomic) NSString *translated;
@property (copy, nonatomic) NSString *pali;
@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *listen_link;
@property (nonatomic, strong, readwrite) AVPlayerViewController *controller;

@end
