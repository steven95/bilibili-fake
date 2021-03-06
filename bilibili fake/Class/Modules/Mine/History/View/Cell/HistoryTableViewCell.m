//
//  HistoryTableViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HistoryTableViewCell
{
    UIImageView *_picImageView;
    UILabel *_titleLabel;
    UILabel *_ownerLabel;
    UILabel *_viewCountLabel;
    UILabel *_danmakuCountLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setHistory:(HistoryEntity *)history {
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:history.pic]];
    _titleLabel.text = history.title;
    _ownerLabel.text = [NSString stringWithFormat:@"UP主: %@", history.ownerName];
    _viewCountLabel.text = [NSString stringWithFormat:@"播放 :%@", IntegerToTenThousand(history.viewCount)];
    _danmakuCountLabel.text = [NSString stringWithFormat:@"弹幕 :%@", IntegerToTenThousand(history.danmakuCount)];
    
    [_titleLabel layoutIfNeeded];
    CGFloat titleHeight = [_titleLabel textRectForBounds:CGRectMake(0, 0, _titleLabel.width, 666) limitedToNumberOfLines:2].size.height;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = titleHeight;
    }];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSMutableArray *rightButtons = [NSMutableArray arrayWithCapacity:4];
        [rightButtons sw_addUtilityButtonWithColor:ColorRGB(253, 85, 98) title:@"删除"];
        [self setRightUtilityButtons:rightButtons];
        
        _picImageView = [[UIImageView alloc] init];
        _picImageView.layer.cornerRadius = 6;
        _picImageView.layer.masksToBounds = YES;
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_picImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(13);
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        _ownerLabel = [[UILabel alloc] init];
        _ownerLabel.font = Font(10);
        _ownerLabel.textColor = ColorWhite(146);
        [self.contentView addSubview:_ownerLabel];
        
        _viewCountLabel = [[UILabel alloc] init];
        _viewCountLabel.font = Font(10);
        _viewCountLabel.textColor = ColorWhite(146);
        [self.contentView addSubview:_viewCountLabel];
        
        _danmakuCountLabel = [[UILabel alloc] init];
        _danmakuCountLabel.font = Font(10);
        _danmakuCountLabel.textColor = ColorWhite(146);
        _danmakuCountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_danmakuCountLabel];
        
        [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 10;
            make.bottom.offset = -10;
            make.width.equalTo(_picImageView.mas_height).multipliedBy(120.0/80.0);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_picImageView.mas_right).offset = 10;
            make.top.equalTo(_picImageView);
            make.right.offset = -10;
            make.height.offset = 30;
        }];
        [_ownerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.bottom.equalTo(_viewCountLabel.mas_top).offset = -10;
            make.right.offset = -10;
            make.height.offset = 11;
        }];
        [_viewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_danmakuCountLabel.mas_left).offset = -10;
            make.height.offset = 11;
            make.bottom.offset = -10;
        }];
        [_danmakuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewCountLabel);
            make.right.offset = -10;
            make.width.offset = 80;
            make.height.offset = 11;
        }];
        
    }
    return self;
}

@end
