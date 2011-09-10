//
//  ButtonBar.m
//  ButtonBar
//

#import "ButtonBar.h"

@implementation ButtonBar

void drawLine(NSColor *color, CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    NSRect rect = NSMakeRect(x, y, width, height);
    NSFrameRectWithWidth(rect, 1);
    [color set];
    NSFrameRect(rect);
}

static NSColor *topLineColor;
static NSColor *bottomLineColor;
static NSColor *topColor;
static NSColor *middleTopColor;
static NSColor *middleBottomColor;
static NSColor *bottomColor;
static NSColor *resizeHandleColor;
static NSGradient *gradient;

+ (void)initialize
{
    topLineColor       = [NSColor colorWithCalibratedWhite:(150.0f / 255.0f) alpha:1.0f];
    bottomLineColor    = [NSColor colorWithCalibratedWhite:(150.0f / 255.0f) alpha:1.0f];
    topColor           = [NSColor colorWithCalibratedWhite:(253.0f / 255.0f) alpha:1.0f];
    middleTopColor     = [NSColor colorWithCalibratedWhite:(243.0f / 255.0f) alpha:1.0f];
    middleBottomColor  = [NSColor colorWithCalibratedWhite:(230.0f / 255.0f) alpha:1.0f];
    bottomColor        = [NSColor colorWithCalibratedWhite:(230.0f / 255.0f) alpha:1.0f];
    resizeHandleColor  = [NSColor colorWithCalibratedWhite:(170.0f / 255.0f) alpha:0.598f];

    gradient = [[NSGradient alloc] initWithColorsAndLocations:
                          topColor, 0.0f,
                          middleTopColor, 0.47f,
                          middleBottomColor, 0.49f,
                          bottomColor, 1.0f,
                          nil];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }

    return self;
}

- (void)drawRect:(NSRect)rect
{
    // Draw gradient
    NSRect gradientRect;
    gradientRect = NSMakeRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 1);
    [gradient drawInRect:gradientRect angle:270];

    // Draw Top line
    drawLine(topLineColor, rect.origin.x, rect.size.height - 1, rect.size.width, rect.size.height - 1);

    // Draw Bottom line
    drawLine(bottomLineColor, rect.origin.x, rect.origin.y, rect.size.width, rect.origin.y);

    // Draw Handle
    for(int i=0; i < 3; i++) {
	drawLine(resizeHandleColor, rect.size.width - 15 + i*4, rect.size.height/2 - 5, 1, 10);
    }
}
@end

