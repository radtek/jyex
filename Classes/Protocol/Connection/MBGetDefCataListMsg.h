//
//  MBGetDefCataListMsg.h
//  pass91
//
//  Created by Zhaolin He on 09-8-31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSocket.h"

@interface MBGetDefCataListMsg : PSocket {
    
}
+ (PSocket*)shareMsg;
-(void)sendPacketWithData:(NSData *)data;
@end
