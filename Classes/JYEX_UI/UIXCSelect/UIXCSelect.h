//
//  UIXCSelect.h
//  JYEX
//
//  Created by zd on 13-12-24.
//  Copyright (c) 2013年 洋基科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussMng.h"
#import "PubFunction.h"


@interface UIXCSelect : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIButton *btnBack ;
    IBOutlet UIButton *btnNavFinish ;
    IBOutlet UITableView *tvXC ;
    IBOutlet UILabel *lbTitle ;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    IBOutlet UIView *vNewXC ; //新建相册
    IBOutlet UITextField *txfXCName ;
    
    NSMutableArray *XCList ;//相册列表
    
    //callback
    //id callBackObject ;
    //SEL callBackSel ;
    
    //参数
    MsgParam* msgParam;
    
    BussMng* bussRequest;
    
    NSArray *schoolXCList ;
    NSArray *classXCList ;
    NSArray *myselfXCList ;
    
    IBOutlet UIButton *btnSchoolS ;//学校空间
    IBOutlet UIButton *btnClassS ;//班级空间
    IBOutlet UIButton *btnMyselfS ;//个人空间
    int spaceType ;//空间类型：学校->1 班级->2 个人->3
    int spaceID ;//0:个人空间 1:班级空间 2:学校空间
    
    int nCreatFlag;
    
}
@property(nonatomic,retain)NSMutableArray *XCList ;
//@property(nonatomic,assign)id callBackObject ;
//@property(nonatomic,assign)SEL callBackSel ;
@property(nonatomic,retain) BussMng *bussRequest;
@property(nonatomic,retain) MsgParam* msgParam;

@property(nonatomic,retain)NSArray *schoolXCList ;
@property(nonatomic,retain)NSArray *classXCList ;
@property(nonatomic,retain)NSArray *myselfXCList ;
@property(nonatomic,readonly,getter = getSchoolFlag)BOOL schoolXCFlag ;
@property(nonatomic,readonly,getter = getClassFlag)BOOL classXCFlag ;
@property(nonatomic,readonly,getter = getMyFlag)BOOL myXCFlag ;

- (IBAction)onCancel:(id)sender ;
- (IBAction)onOK:(id)sender ;
- (IBAction)onHideNewXCView:(id)sender ;
- (IBAction)onSchoolSpaceSelected:(id)sender ;
- (IBAction)onClassSpaceSelected:(id)sender ;
- (IBAction)onMyselfSpaceSelected:(id)sender ;

- (void)initSpaceType ;

//创建相册
- (void)CreateJYEXAlbum ;
- (void)syncCallback_CreateJYEXAlbum:(TBussStatus*)sts ;

//查询相册列表
- (void)QueryJYEXAlbumList ;
- (void)syncCallback_QueryJYEXAlbumList:(TBussStatus*)sts ;

- (BOOL)getSchoolFlag ;

- (BOOL)getClassFlag ;

- (BOOL)getMyFlag ;

- (int)getTableViewSectionType:(int)section ;//1:学校相册 2:班级相册  3:个人相册

@end
