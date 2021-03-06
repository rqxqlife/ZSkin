//
//  ViewControllerLabel.m
//  ZSThemeKitDemo
//
//  Created by peter.shi on 16/7/21.
//  Copyright © 2016年 peter.shi. All rights reserved.
//

#import "ViewControllerLabel.h"
#import "ZRuntimeUtility.h"
#import "NSObject+Skin.h"

@interface ViewControllerLabel ()


@end

@implementation ViewControllerLabel

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void)prepareData
{
    [super prepareData];
    NSArray *propertys = [ZRuntimeUtility propertyNames:[ZColorSkin class]];

    CGFloat offsetY = 0;
    CGFloat interval = 5;
    CGFloat height = 30;
    CGFloat nameWidth = self.view.frame.size.width * 1 / 4;
    CGFloat colorWidth = self.view.frame.size.width * 1 / 4;
    CGFloat descWidth = self.view.frame.size.width * 2 / 4;

    UIFont *font = [UIFont systemFontOfSize:11];
    __weak typeof(self) weakSelf = self;
    for (NSString *property in propertys)
    {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offsetY, nameWidth, height)];
        [nameLabel setFont:font];
        [nameLabel setText:property];
        [nameLabel setTextColor:[UIColor blackColor]];
        [self.view addSubview:nameLabel];

        UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameWidth, offsetY, colorWidth, height)];
        [colorLabel setFont:font];


        [colorLabel bind:^(id sender, ZSkin *skin) {
            SEL selector = NSSelectorFromString(property);
            UIColor *color = [weakSelf.skin.color performSelector:selector];
            CGFloat r, g, b, a;
            [color getRed:&r green:&g blue:&b alpha:&a];

            [(UILabel *)sender setText:[NSString stringWithFormat:@"0x%02x%02x%02x", (int)r * 255, (int)g * 255, (int)b * 255]];
            [(UILabel *)sender setTextColor:color];
        }];

        [self.view addSubview:colorLabel];

        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameWidth + colorWidth, offsetY, descWidth, height)];
        [descLabel setFont:font];
        [descLabel setTextColor:[UIColor blackColor]];
        [descLabel bind:^(id sender, ZSkin *skin) {
            SEL selector = NSSelectorFromString(property);
            UIColor *color = [weakSelf.skin.color performSelector:selector];
            CGFloat r, g, b, a;
            [color getRed:&r green:&g blue:&b alpha:&a];

            [(UILabel *)sender setText:[NSString stringWithFormat:@"rgb : %.2f %.2f %.2f %.2f",r,g,b,a]];
        }];

        [self.view addSubview:descLabel];

        offsetY += height + interval;
    }
}

- (void)dealloc{
    NSLog(@"Dealloc ViewControllerButton");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
