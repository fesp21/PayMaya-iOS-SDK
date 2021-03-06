//
//  PMDCartItemTableViewCell.m
//  PayMayaSDKDemo
//
//  Copyright (c) 2016 PayMaya Philippines, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute,
//  sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "PMDCartItemTableViewCell.h"
#import "PMDUtilities.h"

@interface PMDCartItemTableViewCell ()

@property (nonatomic, strong) UILabel *itemNameLabel;
@property (nonatomic, strong) UILabel *itemPriceLabel;
@property (nonatomic, strong) UILabel *multiplierLabel;
@property (nonatomic, strong) UILabel *itemQuantityLabel;
@property (nonatomic, strong) UILabel *itemPriceTotalLabel;

@end

@implementation PMDCartItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.itemNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemNameLabel.numberOfLines = 0;
        self.itemNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemNameLabel];
        
        self.itemPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemPriceLabel];
        
        self.multiplierLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.multiplierLabel.text = @"X";
        self.multiplierLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.multiplierLabel];
        
        self.itemQuantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemQuantityLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemQuantityLabel];
        
        self.itemPriceTotalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemPriceTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemPriceTotalLabel];
        
        [self setUpLayoutConstraints];
    }
    return self;
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_itemNameLabel, _itemPriceLabel, _multiplierLabel, _itemQuantityLabel, _itemPriceTotalLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_itemNameLabel(75)]-[_itemPriceLabel(80)]-[_multiplierLabel]-[_itemQuantityLabel]->=0-[_itemPriceTotalLabel]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_itemNameLabel]-|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)bindWithProduct:(PMDProduct *)product withQuantity:(NSNumber *)quantity
{
    self.itemNameLabel.text = product.name;
    self.itemPriceLabel.text = [[PMDUtilities currencyFormatter] stringFromNumber:product.amount];
    self.itemQuantityLabel.text = [quantity stringValue];
    self.itemPriceTotalLabel.text = [[PMDUtilities currencyFormatter] stringFromNumber:@([product.amount doubleValue] * [quantity doubleValue])];
}

+ (NSString *)reuseIdentifier
{
    return @"PMDCartItemTableViewCell";
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
