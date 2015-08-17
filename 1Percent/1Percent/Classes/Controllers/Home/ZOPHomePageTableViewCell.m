//
//  ZOPHomePageTableViewCell.m
//  ObjectiveCTestDemo
//
//  Created by 黄穆斌 on 15/8/16.
//  Copyright (c) 2015年 huangmubin. All rights reserved.
//

#import "ZOPHomePageTableViewCell.h"

@implementation ZOPHomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.cellImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.cellImageView.contentMode = UIViewContentModeScaleToFill;
    self.cellImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.cellImageView];
    return self;
}
//
//- (void)setCellImageView:(UIImageView *)cellImageView {
//    
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
