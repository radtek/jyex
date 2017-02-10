//
//  UIJYEXMainPage.h
//  NoteBook
//
//  Created by cyl on 13-4-24.
//  Copyright (c) 2013年 洋基科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussMng.h"

#import "EGORefreshTableHeaderView.h"

@class UIAppList;
@interface UIJYEXMainPage2 : UIViewController<UIScrollViewDelegate,UIWebViewDelegate,EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    IBOutlet UILabel *m_lbTitle;
    IBOutlet UIButton *m_btnSet2;
    
    IBOutlet UIScrollView *m_swAppList;
    
    IBOutlet UIWebView *m_webview1;
    IBOutlet UIWebView *m_webview2;
    IBOutlet UIWebView *m_webview3;
    IBOutlet UIWebView *m_webview4;
    IBOutlet UIWebView *m_webview5;
    
    IBOutlet UIButton *m_btnCamer;
    IBOutlet UIButton *m_btnEditLog;
    IBOutlet UIButton *m_btnSend;
    IBOutlet UIButton *m_btnSetting;
    IBOutlet UIButton *m_btnPerson;
    IBOutlet UIView   *m_vwAnimation;
    
    IBOutlet UIView *m_vwComBack;
    IBOutlet UILabel *m_labelComTitle;
    IBOutlet UITextView *m_twComText;
    IBOutlet UIButton *m_btnClostCom;
    
    IBOutlet UILabel *m_lbTips;
    IBOutlet UIView  *m_vwTips;
    IBOutlet UILabel *m_lbTips1;
    IBOutlet UIView  *m_vwTips1;
    IBOutlet UILabel *m_lbTips2;
    IBOutlet UIView  *m_vwTips2;
    IBOutlet UILabel *m_lbTips3;
    IBOutlet UIView  *m_vwTips3;
    IBOutlet UILabel *m_lbTips4;
    IBOutlet UIView  *m_vwTips4;
    IBOutlet UILabel *m_lbTips5;
    IBOutlet UIView  *m_vwTips5;
    
    //test
    IBOutlet UIView *m_vwTitleView;
    IBOutlet UILabel *M_lbColor;
    
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIView *m_vwActivityBack;
    
    IBOutlet UIButton *btnMenu;
    
    IBOutlet UIView *vwNoteType;
    IBOutlet UITableView *twNoteTypeList;
    IBOutlet UIButton *btnHideNoteTypeList;
    IBOutlet UIView *vwBack;
    
    NSArray *boughtApp;
    NSArray *nominateApp;
    
    NSTimer *timer;  //刷新定时器
    NSTimeInterval m_timeinterval;
    
    BussMng* bussRequest;
    
    
    EGORefreshTableHeaderView *_refreshHeaderView[5];
    int m_syncflag[5];
    unsigned long m_syncid[5];
    
    //左右滑动时，开始的页面
    int m_nStartPage;
    int m_nCurPage;
    CGFloat fPosX;
    int nDragFlag;
  
    NSArray *m_Menu1;
    NSArray *m_Menu2;
    NSArray *m_Menu3;
    NSArray *m_Menu4;
    NSArray *m_Menu5;
    
    NSDate *m_Date1;
    NSDate *m_Date2;
    NSDate *m_Date3;
    NSDate *m_Date4;
    NSDate *m_Date5;
    
}


@property(nonatomic, retain) NSArray *boughtApp;
@property(nonatomic, retain) NSArray *nominateApp;
@property (nonatomic,retain) BussMng *bussRequest;

@property(nonatomic, retain) NSArray *m_Menu1;
@property(nonatomic, retain) NSArray *m_Menu2;
@property(nonatomic, retain) NSArray *m_Menu3;
@property(nonatomic, retain) NSArray *m_Menu4;
@property(nonatomic, retain) NSArray *m_Menu5;
@property(nonatomic, retain) NSDate *m_Date1;
@property(nonatomic, retain) NSDate *m_Date2;
@property(nonatomic, retain) NSDate *m_Date3;
@property(nonatomic, retain) NSDate *m_Date4;
@property(nonatomic, retain) NSDate *m_Date5;


//-(void)drawAppList;
//-(void)onSelectApp:(id)appInfo;
-(IBAction)onBlog:(id)sender;
-(IBAction)onSend:(id)sender;
-(IBAction)onCamera:(id)sender;
-(IBAction)onSetting:(id)sender;
-(IBAction)onCloseCom:(id)sender;
-(IBAction)onFunc:(id)sender;

-(IBAction)onDispOrHideNoteType:(id)sender;

//test
-(IBAction)onPictureSend:(id)sender ;
-(IBAction)onTest:(id)sender ;


@end
