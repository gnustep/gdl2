/**
    AdaptorsPanel.m
 
    Author: Matt Rice <ratmice@gmail.com>
    Date: Apr 2005

    This file is part of DBModeler.
    
    <license>
    DBModeler is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    DBModeler is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DBModeler; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
    </license>
**/

#include "AdaptorsPanel.h"
#include <AppKit/AppKit.h>

#include <GNUstepBase/GNUstep.h>

static NSArray *_adaptorNames;

@implementation AdaptorsPanel

- (void) dealloc
{
  DESTROY(_window);
  DESTROY(_adaptorNames);
  /* released by window 
  _label
  brws_adaptors
  btn_ok
  btn_cancel
  */
  [super dealloc];
}

- (id) init
{
  if ((self = [super init]))
    {
      NSRect fr1, fr2;
      _adaptorNames = RETAIN([EOAdaptor availableAdaptorNames]);
      /* redo all these numbers so buttons and labels are on the right? */
      _window = [[NSWindow alloc]
                initWithContentRect: NSMakeRect(200,200,200,300)
                          styleMask: NSBorderlessWindowMask | NSTitledWindowMask
                            backing: NSBackingStoreBuffered
                              defer: YES];
      [_window setTitle: @"Select adaptor"];
      [_window setReleasedWhenClosed:NO];
      
      brws_adaptors = [[NSBrowser alloc] initWithFrame: NSMakeRect(5,30,190,240)];
      [brws_adaptors setDelegate: self];
      [brws_adaptors addColumn];
      [brws_adaptors setTitle: @"Available adaptors" ofColumn: 0];
      [brws_adaptors setAllowsEmptySelection: NO];
      [brws_adaptors setTarget:self];
      [brws_adaptors setDoubleAction:@selector(ok:)];
      
      btn_ok = [[NSButton alloc] initWithFrame: NSMakeRect(5,5,50,20)];
      [btn_ok setTitle: @"ok"];
      [btn_ok setTarget: self];
      [btn_ok setAction: @selector(ok:)];
      
      btn_cancel = [[NSButton alloc] initWithFrame: NSMakeRect(60,5,50,20)];
      [btn_cancel setTitle: @"cancel"];
      [btn_cancel setTarget: self];
      [btn_cancel setAction: @selector(cancel:)];
    
      [[_window contentView] addSubview: brws_adaptors];
      [[_window contentView] addSubview: btn_ok];
      [[_window contentView] addSubview: btn_cancel];
      
      [_window setInitialFirstResponder:brws_adaptors];
      [brws_adaptors setNextResponder:btn_ok];
      [btn_ok setNextResponder:btn_cancel];
// hmm.. this seems to cause an infinate loop in the responder chain somehow
// when in the modal loop.
//      [btn_cancel setNextResponder:brws_adaptors];
      
      [btn_ok setKeyEquivalent:@"\r"];
      [btn_ok setImage:[NSImage imageNamed:@"common_ret"]];
      [btn_ok setAlternateImage:[NSImage imageNamed:@"common_retH"]];
      [btn_ok setImagePosition:NSImageRight];
      [btn_ok sizeToFit];
  
      fr1 = [btn_ok frame];
      fr2 = [btn_cancel frame];
      
      fr1.size.width = fr2.size.width = fr1.size.width > fr2.size.width
                                        ? fr1.size.width
                                        : fr2.size.width;
      fr1.size.height = fr2.size.height = fr1.size.height > fr2.size.height
                                        ? fr1.size.height
                                        : fr2.size.height;
      fr2.origin.x = NSMaxX(fr1) + 8;
      
      [btn_ok setFrame:fr1];
      [btn_cancel setFrame:fr2];

      fr2 = [brws_adaptors frame];
      fr2.origin.y = NSMaxY(fr1) + 8;
      [brws_adaptors setFrame:fr2];
    
      RELEASE(_label);
      RELEASE(brws_adaptors);
      RELEASE(btn_ok);
      RELEASE(btn_cancel);
      
  }
  return self;
}

- (NSString *) runAdaptorsPanel
{
  NSString *selection;

  if ([NSApp runModalForWindow:_window] == NSRunAbortedResponse)
    {
      selection = nil;
      [_window orderOut:self];
    }
  else 
    {
      selection = [[brws_adaptors selectedCell] stringValue];
      [_window orderOut:self];
    }
  return selection;
}

/* button actions */

- (void) ok: (id)sender
{
  [NSApp stopModalWithCode:NSRunStoppedResponse];
}

- (void) cancel: (id)sender
{
  [NSApp stopModalWithCode:NSRunAbortedResponse];
}

/* NSBrowser delegate stuff */

- (int) browser:(id)sender numberOfRowsInColumn:(int)column
{
  return [_adaptorNames count];
}

- (void)browser:(NSBrowser*)sender
        willDisplayCell:(NSBrowserCell*)cell
                  atRow:(int)row
                 column:(int)column
{
  [cell setLeaf:YES];
  [cell setTitle: [_adaptorNames objectAtIndex:row]];
}



@end

