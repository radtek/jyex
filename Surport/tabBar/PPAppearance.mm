#import "PPAppearance.h"
#import "Constant.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

static PPAppearance* gAppearance = nil;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation PPAppearance

@synthesize navigationBarTintColor = _navigationBarTintColor,
toolbarTintColor = _toolbarTintColor,
linkTextColor = _linkTextColor,
moreLinkTextColor = _moreLinkTextColor,
tableActivityTextColor = _tableActivityTextColor, 
tableErrorTextColor = _tableErrorTextColor, 
tableSubTextColor = _tableSubTextColor, 
tableTitleTextColor = _tableTitleTextColor, 
placeholderTextColor = _placeholderTextColor, 
searchTableBackgroundColor = _searchTableBackgroundColor,
searchTableSeparatorColor = _searchTableSeparatorColor,
tableHeaderTextColor = _tableHeaderTextColor,
tableHeaderShadowColor = _tableHeaderShadowColor,
tableHeaderTintColor = _tableHeaderTintColor,
blackButtonImage = _blackButtonImage,
buttonTitleColor = _buttonTitleColor,
textDescriptionColor = _textDescriptionColor;
@synthesize buttonUpImage = _buttonUpImage,
buttonDownImage = _buttonDownImage,
buttonShadowColor = _buttonShadowColor,
buttonShadowOffset = _buttonShadowOffset,skinPath,imagePath;

+ (PPAppearance*)appearance {
	if (!gAppearance) {
		[[PPAppearance alloc] init];
		//[self setAppearance:[[[PPAppearance alloc] init] autorelease]];
	}
	return gAppearance;
}
- (void)setSkinPath:(NSString*)s{
	[s retain];
	[skinPath release];
	skinPath = s;
	UIImage *tmp = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonDown" ofType:@"png" inDirectory:skinPath]];
	self.buttonDownImage = [tmp stretchableImageWithLeftCapWidth:16 topCapHeight:16];
	tmp = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonUp" ofType:@"png" inDirectory:skinPath]];
	self.buttonUpImage = [tmp stretchableImageWithLeftCapWidth:16 topCapHeight:16];	
}
+ (UIButton*)commonButtonWithFrame:(CGRect)frame title:(NSString*)title target:(id)target action:(SEL)action{
	UIButton *bn = [UIButton buttonWithType:UIButtonTypeCustom];
	[bn setFrame:frame];
	[bn setTitle:title forState:UIControlStateNormal];
	[bn setTitleColor:[PPAppearance appearance].buttonTitleColor forState:UIControlStateNormal];
	[bn setBackgroundImage:[PPAppearance appearance].buttonUpImage forState:UIControlStateNormal];
	[bn setBackgroundImage:[PPAppearance appearance].buttonDownImage forState:UIControlStateHighlighted];
	[bn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	bn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
	bn.titleLabel.shadowOffset = [PPAppearance appearance].buttonShadowOffset;
	[bn setTitleShadowColor:[PPAppearance appearance].buttonShadowColor forState:UIControlStateNormal];
	return bn;
}
//+ (void)setAppearance:(PPAppearance*)appearance {
//  if (gAppearance != appearance) {
//    [gAppearance release];
//    gAppearance = [appearance retain];
//  }
//}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (id)init {
	if (self = [super init]) {
		gAppearance = self;
		self.skinPath = @"Resource/Skin";
		self.imagePath = @"Image";
		self.navigationBarTintColor = nil;
		self.toolbarTintColor = RGBCOLOR(109, 132, 162);
		self.linkTextColor = RGBCOLOR(84, 92, 113);
		self.moreLinkTextColor = RGBCOLOR(36, 112, 216);
		self.tableActivityTextColor = RGBCOLOR(99, 109, 125);
		self.tableErrorTextColor = RGBCOLOR(99, 109, 125);
		self.tableSubTextColor = RGBCOLOR(99, 109, 125);
		self.tableTitleTextColor = RGBCOLOR(99, 109, 125);
		self.placeholderTextColor = RGBCOLOR(180, 180, 180);
		self.searchTableBackgroundColor = RGBCOLOR(235, 235, 235);
		self.textDescriptionColor = [UIColor colorWithRed:0.20 green:0.30 blue:0.50 alpha:1]; 
		self.searchTableSeparatorColor = [UIColor colorWithWhite:0.85 alpha:1];
		self.buttonTitleColor = RGBCOLOR(56.0,56.0,56.0);
		UIImage *tmp = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonDown" ofType:@"png" inDirectory:[PPAppearance appearance].skinPath]];
		self.buttonDownImage = [tmp stretchableImageWithLeftCapWidth:16 topCapHeight:16];
		tmp = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonUp" ofType:@"png" inDirectory:[PPAppearance appearance].skinPath]];
		self.buttonUpImage = [tmp stretchableImageWithLeftCapWidth:16 topCapHeight:16];
		self.buttonShadowColor = [UIColor whiteColor];
		self.buttonShadowOffset = CGSizeMake(1,1);
		_tableHeaderTextColor = nil;
		_tableHeaderShadowColor = nil;
		_tableHeaderTintColor = nil;
		_blackButtonImage = nil;
	}
	return self;
}

- (void)dealloc {
	[_navigationBarTintColor release];
	[_toolbarTintColor release];
	[_linkTextColor release];
	[_moreLinkTextColor release];
	[_tableActivityTextColor release];
	[_tableErrorTextColor release];
	[_tableSubTextColor release];
	[_tableTitleTextColor release];
	[_placeholderTextColor release];
	[_searchTableBackgroundColor release];
	[_searchTableSeparatorColor release];
	[_tableHeaderTextColor release];
	[_tableHeaderShadowColor release];
	[_tableHeaderTintColor release];
	[_blackButtonImage release];
	[_buttonTitleColor release];
	[_textDescriptionColor release];
	[skinPath release];
	[imagePath release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
	CGContextBeginPath(context);
	CGContextSaveGState(context);
	
	if (radius == 0) {
		CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextAddRect(context, rect);
	} else {
		rect = CGRectOffset(CGRectInset(rect, 0.5, 0.5), 0.5, 0.5);
		CGContextTranslateCTM(context, CGRectGetMinX(rect)-0.5, CGRectGetMinY(rect)-0.5);
		CGContextScaleCTM(context, radius, radius);
		float fw = CGRectGetWidth(rect) / radius;
		float fh = CGRectGetHeight(rect) / radius;
		
		CGContextMoveToPoint(context, fw, fh/2);
		CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
		CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
		CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
		CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	}
	
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}

- (void)addInvertedRoundedRectPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, nil, rect);
	CGPathCloseSubpath(path);
	
	if (radius == 0) {
		CGContextAddRect(context, rect);
	} else {
		float fw = CGRectGetWidth(rect) / radius;
		float fh = CGRectGetHeight(rect) / radius;
		
		CGPathMoveToPoint(path, nil, fw, fh/2);
		CGPathAddArcToPoint(path, nil, fw, fh, fw/2, fh, 1);
		CGPathAddArcToPoint(path, nil, 0, fh, 0, fh/2, 1);
		CGPathAddArcToPoint(path, nil, 0, 0, fw/2, 0, 1);
		CGPathAddArcToPoint(path, nil, fw, 0, fw, fh/2, 1);
		CGPathCloseSubpath(path);
	}
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextScaleCTM(context, radius, radius);
	CGContextAddPath(context, path);
	CGContextRestoreGState(context);
	
	CGPathRelease(path);
}

- (CGGradientRef)gradientWithColors:(UIColor**)colors count:(int)count
							  space:(CGColorSpaceRef)space {
	CGFloat* components = (CGFloat*)malloc(sizeof(CGFloat)*4*count);
	CGFloat* locations = nil;//malloc(sizeof(CGFloat)*count);
	for (int i = 0; i < count; ++i) {
		//locations[i] = i/(count-1);
		
		UIColor* color = colors[i];
		size_t n = CGColorGetNumberOfComponents(color.CGColor);
		const CGFloat* rgba = CGColorGetComponents(color.CGColor);
		if (n == 2) {
			components[i*4] = rgba[0];
			components[i*4+1] = rgba[0];
			components[i*4+2] = rgba[0];
			components[i*4+3] = rgba[1];
		} else if (n == 4) {
			components[i*4] = rgba[0];
			components[i*4+1] = rgba[1];
			components[i*4+2] = rgba[2];
			components[i*4+3] = rgba[3];
		}
	}
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, count);
	free(components);
	//free(locations);
	return gradient;
}

- (void)drawRoundedRect:(CGRect)rect fill:(UIColor**)fillColors fillCount:(int)fillCount
				 stroke:(UIColor*)strokeColor thickness:(CGFloat)thickness radius:(CGFloat)radius {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (radius == PP_RADIUS_ROUNDED) {
		radius = rect.size.height/2;
	}
	
	if (fillColors) {
		CGContextSaveGState(context);
		[self addRoundedRectToPath:context rect:rect radius:radius];
		[self fill:rect fillColors:fillColors count:fillCount];
		CGContextRestoreGState(context);
	}
	
	if (strokeColor) {
		CGContextSaveGState(context);
		[self addRoundedRectToPath:context rect:rect radius:radius];
		[self stroke:strokeColor thickness:thickness];
		CGContextRestoreGState(context);
	}
}

- (void)drawRoundedMask:(CGRect)rect fill:(UIColor**)fillColors stroke:(UIColor*)strokeColor
			  thickness:(CGFloat)thickness radius:(CGFloat)radius {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (radius == PP_RADIUS_ROUNDED) {
		radius = rect.size.height/2;
	}
	
	if (fillColors) {
		CGContextSaveGState(context);
		[self addInvertedRoundedRectPath:context rect:rect radius:radius];
		[fillColors[0] setFill];
		CGContextEOFillPath(context);
		CGContextRestoreGState(context);
	}
	
	if (strokeColor) {
		CGContextSaveGState(context);
		[self addRoundedRectToPath:context rect:rect radius:radius];
		[strokeColor setStroke];
		CGContextSetLineWidth(context, thickness);
		CGContextStrokePath(context);
		CGContextRestoreGState(context);
	}
}

- (void)drawReflection:(CGRect)rect fill:(UIColor**)fillColors fillCount:(int)fillCount
				stroke:(UIColor*)strokeColor thickness:(CGFloat)thickness radius:(CGFloat)radius {
	if (fillColors && fillCount) {
		UIColor* tintColor = fillColors[0];
		UIColor* ligherTint = [tintColor transformHue:1 saturation:0.4 value:1.1];
		UIColor* barFill[] = {ligherTint, tintColor};
		
		CGRect topRect = CGRectMake(rect.origin.x, rect.origin.y,
									rect.size.width, rect.size.height/1.5);
		[self draw:PPStyleFill rect:topRect
			  fill:barFill fillCount:2 stroke:nil thickness:thickness radius:0];
		
		UIColor* tintFill[] = {tintColor};
		CGRect bottomRect = CGRectMake(rect.origin.x, ceil(rect.origin.y+rect.size.height/(2*2)),
									   rect.size.width, (rect.size.height/2));
		[self draw:PPStyleFill rect:bottomRect
			  fill:tintFill fillCount:1 stroke:nil thickness:thickness radius:0];
		
		UIColor* highlight = [UIColor colorWithWhite:1 alpha:0.3];
		[self draw:PPStyleStrokeTop rect:CGRectInset(rect, 0, 1)
			  fill:nil fillCount:0 stroke:highlight thickness:thickness radius:0];
		
		UIColor* shadow = [UIColor colorWithWhite:0 alpha:0.1];
		[self draw:PPStyleStrokeBottom rect:rect
			  fill:nil fillCount:0 stroke:shadow thickness:thickness radius:0];
	}
}

- (void)drawInnerShadow:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
	CGContextSaveGState(context);
	
	CGFloat components[] = {0, 0, 0, 0.15, 0, 0, 0, 0};
	CGFloat locations[] = {0, 0.5};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);
	CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0),
								CGPointMake(0, rect.size.height), kCGGradientDrawsBeforeStartLocation);
	CGGradientRelease(gradient);
	
	CGPoint topLine[] = {0, 0, rect.size.width, 0};
	CGFloat shadowColor[] = {130/256.0, 130/256.0, 130/256.0, 1};
	CGContextSetStrokeColorSpace(context, space);
	CGContextSetStrokeColor(context, shadowColor);
	CGContextStrokeLineSegments(context, topLine, 2);
	
	CGColorSpaceRelease(space);
	CGContextRestoreGState(context);
}

- (void)drawRoundInnerShadow:(CGRect)rect fill:(UIColor**)fillColors fillCount:(int)fillCount
					  stroke:(UIColor*)strokeColor thickness:(CGFloat)thickness radius:(CGFloat)radius {
	UIImage* image = [[UIImage imageNamed:@"roundBox.png"]
					  stretchableImageWithLeftCapWidth:15 topCapHeight:15];
	[image drawInRect:rect];
	
	if (strokeColor) {
		[self drawRoundedRect:rect fill:nil fillCount:0 stroke:strokeColor thickness:thickness
					   radius:PP_RADIUS_ROUNDED];
	}
}

- (void)strokeLines:(CGRect)rect style:(PPStyle)style stroke:(UIColor*)strokeColor
		  thickness:(CGFloat)thickness {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	[strokeColor setStroke];
	CGContextSetLineWidth(context, thickness);
	
	if (style == PPStyleStrokeTop) {
		CGPoint points[] = {rect.origin.x, rect.origin.y-0.5,
		rect.origin.x+rect.size.width, rect.origin.y-0.5};
		CGContextStrokeLineSegments(context, points, 2);
	}
	if (style == PPStyleStrokeRight) {
		CGPoint points[] = {rect.origin.x+rect.size.width, rect.origin.y,
		rect.origin.x+rect.size.width, rect.origin.y+rect.size.height};
		CGContextStrokeLineSegments(context, points, 2);
	}
	if (style == PPStyleStrokeBottom) {
		CGPoint points[] = {rect.origin.x, rect.origin.y+rect.size.height-0.5,
		rect.origin.x+rect.size.width, rect.origin.y+rect.size.height-0.5};
		CGContextStrokeLineSegments(context, points, 2);
	}
	if (style == PPStyleStrokeLeft) {
		CGPoint points[] = {rect.origin.x, rect.origin.y,
		rect.origin.x, rect.origin.y+rect.size.height};
		CGContextStrokeLineSegments(context, points, 2);
	}
	
	CGContextRestoreGState(context);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (UIImage*)blackButtonImage {
	if (!_blackButtonImage) {
		_blackButtonImage = [[[UIImage imageNamed:@"TroundBox.png"]
							  stretchableImageWithLeftCapWidth:5 topCapHeight:15] retain];
	}
	return _blackButtonImage;
}

- (void)draw:(PPStyle)style rect:(CGRect)rect fill:(UIColor**)fillColors
   fillCount:(int)fillCount stroke:(UIColor*)strokeColor radius:(CGFloat)radius {
	[self draw:style rect:rect fill:fillColors fillCount:fillCount stroke:strokeColor
	 thickness:1 radius:radius];
}

- (void)draw:(PPStyle)style rect:(CGRect)rect fill:(UIColor**)fillColors
   fillCount:(int)fillCount stroke:(UIColor*)strokeColor thickness:(CGFloat)thickness
	  radius:(CGFloat)radius {
	switch (style) {
		case PPStyleFill:
			[self drawRoundedRect:rect fill:fillColors fillCount:fillCount stroke:strokeColor
						thickness:thickness radius:radius];
			break;
		case PPStyleFillInverted:
			[self drawRoundedMask:rect fill:fillColors stroke:strokeColor thickness:thickness
						   radius:radius];
			break;
		case PPStyleReflection:
			[self drawReflection:rect fill:fillColors fillCount:fillCount stroke:strokeColor
					   thickness:thickness radius:radius];
			break;
		case PPStyleInnerShadow:
			[self drawInnerShadow:rect];
			break;
		case PPStyleRoundInnerShadow:
			[self drawRoundInnerShadow:rect fill:fillColors fillCount:fillCount stroke:strokeColor
							 thickness:thickness radius:radius];
			break;
		case PPStyleStrokeTop:
		case PPStyleStrokeRight:
		case PPStyleStrokeBottom:
		case PPStyleStrokeLeft:
			[self strokeLines:rect style:style stroke:strokeColor thickness:thickness];
			break;
		default:
			break;
	}
}

- (void)draw:(PPStyle)style rect:(CGRect)rect {
	[self draw:style rect:rect fill:nil fillCount:0 stroke:nil
		radius:PP_RADIUS_ROUNDED];
}

- (void)drawLine:(CGPoint)from to:(CGPoint)to color:(UIColor*)color thickness:(CGFloat)thickness {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	CGPoint points[] = {from.x, from.y, to.x, from.y};
	[color setStroke];
	CGContextSetLineWidth(context, thickness);
	CGContextStrokeLineSegments(context, points, 2);
	
	CGContextRestoreGState(context);
}

- (void)fill:(CGRect)rect fillColors:(UIColor**)fillColors count:(int)count {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
	
	if (count > 1) {
		CGContextClip(context);
		CGGradientRef gradient = [self gradientWithColors:fillColors count:count space:space];
		CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0),
									CGPointMake(0, rect.size.height), kCGGradientDrawsAfterEndLocation);
		CGGradientRelease(gradient);
	} else {
		[fillColors[0] setFill];
		CGContextFillPath(context);
	}
	
	CGColorSpaceRelease(space);
}

- (void)stroke:(UIColor*)strokeColor thickness:(CGFloat)thickness {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[strokeColor setStroke];
	CGContextSetLineWidth(context, thickness);
	CGContextStrokePath(context);
}

@end
