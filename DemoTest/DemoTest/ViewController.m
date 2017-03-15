//
//  ViewController.m
//  DemoTest
//
//  Created by 16mm1 on 3/12/17.
//  Copyright © 2017 SInc. All rights reserved.
//

#import "ViewController.h"
#import "MyTapGestureRecognizer.h"
#import "TDServices.h"




#define darkBackOpacity 192 //255  192  127  64
@interface ViewController ()

@end

// mb progress hud

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize winSize=[[UIScreen mainScreen] bounds].size;
    
    self.view.frame=CGRectMake(0, 0, winSize.width, winSize.height);
    self.view.userInteractionEnabled=YES;
    self.view.backgroundColor = [UIColor clearColor];
    [self newTableCreate];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    
    [[TDServices sharedService] fetchOwnerWiFiWith:@"23" successBlock:^(NSArray *data){
        
        NSLog(@"alldata-->> %@", data);
        
        NSMutableArray *dataDict=[data objectAtIndex:1];
        NSLog(@"dataDict-->> %@", [dataDict objectAtIndex:0]);
        NSLog(@"dataDict--2>> %@", [[dataDict objectAtIndex:0] objectForKey:@"latitude"]);
        
        
        }
    errorBlock:^(NSError *error, NSDictionary *dict){
    NSLog(@"error-->> %@", error);
        }];
}


-(void) newTableCreate
{
    UITableView *myTableView;
    
    if(!myTableView)
        myTableView = [self newTableView];
    [self.view addSubview:myTableView];
}


-(UITableView*) newTableView {
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectZero];
    tv.delegate = self;
    tv.dataSource = self;
    tv.opaque = YES;
    tv.backgroundColor = [UIColor clearColor];
    tv.decelerationRate = 0.2;
    tv.bounces = YES;
    //tv.pagingEnabled=YES;
   // tv.transform=CGAffineTransformMakeRotation(-M_PI/2);
    tv.separatorColor=[UIColor clearColor];
    tv.showsVerticalScrollIndicator=NO;
    tv.delaysContentTouches=YES;
    tv.layer.cornerRadius=10;

    tv.frame = CGRectMake(20, 50, self.view.frame.size.width-40, 400);
    return tv;
}


#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected Cell-->> %ld", indexPath.row);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *myIdentifier = [NSString stringWithFormat:@"identifier-%d",(int)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.opaque = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.layer.cornerRadius=10;
        [cell setBackgroundColor:[UIColor clearColor]];
        //cell.transform=CGAffineTransformMakeRotation(M_PI/2);
//        if ((int)indexPath.row%2) {
//            [cell setBackgroundColor:[UIColor whiteColor]];
//        }
//        else
//            [cell setBackgroundColor:[UIColor blackColor]];
        
        
        UIView *cellView=[[UIView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-50,140)];
        cellView.backgroundColor=((int)indexPath.row%2)? [UIColor blackColor]:[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:darkBackOpacity/255.0f];
        cellView.opaque = YES;
        cellView.layer.cornerRadius=10;
        [cell.contentView addSubview:cellView];
        
        NSString *backgroundImageName = [NSString stringWithFormat:@"test.png"];
        UIImage *btnBuyImage=[UIImage imageNamed:backgroundImageName];
        UIImageView *btnBuyImageView=[[UIImageView alloc] initWithImage:btnBuyImage];
        btnBuyImageView.frame=CGRectMake(5, 5, 100, 100);
        [cell.contentView addSubview: btnBuyImageView];
        
        
        UIView *claimView=[[UIView alloc] initWithFrame:CGRectMake(btnBuyImageView.frame.origin.x+btnBuyImageView.frame.size.width+10, 10, 150, 50)];
        claimView.backgroundColor= [UIColor whiteColor];//[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:darkBackOpacity/255.0f];
        claimView.opaque = YES;
        claimView.layer.cornerRadius=10;
        [cell.contentView addSubview:claimView];
        
        
        UILabel *freeClaimLabel=[[UILabel alloc] initWithFrame:CGRectMake(claimView.frame.origin.x, claimView.frame.origin.y, claimView.frame.size.width, claimView.frame.size.height)];
        freeClaimLabel.text=[NSString stringWithFormat:@"Free Claim"];
        freeClaimLabel.font=[UIFont fontWithName:@"Georgia" size:20];
        freeClaimLabel.adjustsFontSizeToFitWidth=YES;
        freeClaimLabel.textAlignment=NSTextAlignmentCenter;
        freeClaimLabel.textColor=[UIColor blackColor];//[UIColor colorWithWhite:1.0f alpha:1.0f];
        freeClaimLabel.backgroundColor=[UIColor clearColor];
        freeClaimLabel.autoresizingMask=UIViewAutoresizingFlexibleRightMargin;
        [cell.contentView addSubview:freeClaimLabel];
        
        MyTapGestureRecognizer *tapGestureInstant=[[MyTapGestureRecognizer alloc] init];
        tapGestureInstant.tag=(int)indexPath.row;
        [tapGestureInstant addTarget:self action:@selector(buttonClicked:)];
        [claimView addGestureRecognizer:tapGestureInstant];
        
        
        UIImage *btnMarketImage=[UIImage imageNamed:[NSString stringWithFormat:@"claim.png"]];
        //btnMarketImage=[self scaleWithScaleFactor:btnMarketImage];
        UIButton *btnclaim = [UIButton buttonWithType:UIButtonTypeCustom];
        btnclaim.frame = CGRectMake(claimView.frame.origin.x, claimView.frame.origin.y+60, claimView.frame.size.width, claimView.frame.size.height);
        btnclaim.tag=(int)indexPath.row;
        [btnclaim setImage:btnMarketImage forState:UIControlStateNormal];
        [btnclaim addTarget:self action:@selector(marketButtonCallBack:) forControlEvents:UIControlEventTouchDown];
        [cell.contentView addSubview:btnclaim];
        
        
        UILabel *lblClaim=[[UILabel alloc] initWithFrame:CGRectMake(btnclaim.frame.origin.x, btnclaim.frame.origin.y, btnclaim.frame.size.width, btnclaim.frame.size.height)];
        lblClaim.text=[NSString stringWithFormat:@"Claim"];
        lblClaim.font=[UIFont fontWithName:@"Georgia" size:20];
        lblClaim.adjustsFontSizeToFitWidth=YES;
        lblClaim.textAlignment=NSTextAlignmentCenter;
        lblClaim.textColor=[UIColor blackColor];//[UIColor colorWithWhite:1.0f alpha:1.0f];
        lblClaim.backgroundColor=[UIColor clearColor];
        lblClaim.autoresizingMask=UIViewAutoresizingFlexibleRightMargin;
        [cell.contentView addSubview:lblClaim];
    }
    
    return cell;
}

-(void) buttonClicked:(id) sender
{
    int index = [(MyTapGestureRecognizer*)sender tag];
    
    NSLog(@"index--->> %d", index);
}


-(void) marketButtonCallBack:(id) sender
{
    int index = (int)[(UIButton*)sender tag];
    NSLog(@"index--->> %d", index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
