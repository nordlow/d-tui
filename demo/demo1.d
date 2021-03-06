/**
 * D Text User Interface library - demonstration program
 *
 * Version: $Id$
 *
 * Author: Kevin Lamonte, <a href="mailto:kevin.lamonte@gmail.com">kevin.lamonte@gmail.com</a>
 *
 * License: LGPLv3 or later
 *
 * Copyright: This module is licensed under the GNU Lesser General
 * Public License Version 3.  Please see the file "COPYING" in this
 * directory for more information about the GNU Lesser General Public
 * License Version 3.
 *
 *     Copyright (C) 2013  Kevin Lamonte
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 3 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, see
 * http://www.gnu.org/licenses/, or write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
 */

import std.array;
import std.format;
import std.stdio;
import tui;

private class DemoCheckboxWindow : TWindow {

    /// Constructor
    this(TApplication parent) {
	this(parent, TWindow.Flag.CENTERED | TWindow.Flag.RESIZABLE);
    }

    /// Constructor
    this(TApplication parent, Flag flags) {
	// Construct a demo window.  X and Y don't matter because it
	// will be centered on screen.
	super(parent, "Radiobuttons and Checkboxes", 0, 0, 60, 15, flags);

	uint row = 1;

	// Add some widgets
	addLabel("Check box example 1", 1, row);
	addCheckbox(35, row++, "Checkbox 1");
	addLabel("Check box example 2", 1, row);
	addCheckbox(35, row++, "Checkbox 2", true);
	row += 2;

	auto group = addRadioGroup(1, row, "Group 1");
	group.addRadioButton("Radio option 1");
	group.addRadioButton("Radio option 2");
	group.addRadioButton("Radio option 3");

	addButton("&Close Window", (width - 14) / 2, height - 4,
	    {
		application.closeWindow(this);
	    }

	);
    }

}

private class DemoTextWindow : TWindow {

    /// Hang onto my TText so I can resize it with the window
    private TText textField;

    /// Constructor
    this(TApplication parent) {
	super(parent, "Text Areas", 0, 0, 44, 20, TWindow.Flag.RESIZABLE);

	textField = addText(
	    q"EOS
This is an example of a reflowable text field.  Some example text follows.

This library implements a text-based windowing system loosely
reminiscient of Borland's [Turbo
Vision](http://en.wikipedia.org/wiki/Turbo_Vision) library.  For those
wishing to use the actual C++ Turbo Vision library, see [Sergio
Sigala's updated version](http://tvision.sourceforge.net/) that runs
on many more platforms.

Currently the only console platform supported is Posix (tested on
Linux).  Input/output is handled through terminal escape sequences
generated by the library itself: ncurses is not required or linked to.
xterm mouse tracking using UTF8 coordinates is supported.

This library is licensed LGPL ("GNU Lesser General Public License")
version 3 or greater.  See the file COPYING for the full license text,
which includes both the GPL v3 and the LGPL supplemental terms.

EOS",
	    1, 1, 40, 16);
    }

    /**
     * Handle window/screen resize events.
     *
     * Params:
     *    event = resize event
     */
    override protected void onResize(TResizeEvent event) {
	if (event.type == TResizeEvent.Type.Widget) {
	    // Resize the text field
	    textField.width = event.width - 4;
	    textField.height = event.height - 4;
	    textField.reflow();
	    return;
	}

	// Pass to children instead
	foreach (w; children) {
	    w.onResize(event);
	}
    }
}

private class DemoTreeViewWindow : TWindow {

    /// Hang onto my TTreeView so I can resize it with the window
    TTreeView treeView;

    /// Constructor
    this(TApplication parent) {
	super(parent, "Tree View", 0, 0, 44, 16, TWindow.Flag.RESIZABLE);

	// Load the treeview with "stuff"
	treeView = addTreeView(1, 1, 40, 12);
	TDirTreeItem root = new TDirTreeItem(treeView, ".", true);
    }


    /**
     * Handle window/screen resize events.
     *
     * Params:
     *    event = resize event
     */
    override protected void onResize(TResizeEvent event) {
	if (event.type == TResizeEvent.Type.Widget) {
	    // Resize the text field
	    treeView.width = event.width - 4;
	    treeView.height = event.height - 4;
	    treeView.reflow();
	    return;
	}

	// Pass to children instead
	foreach (w; children) {
	    w.onResize(event);
	}
    }

}

private class DemoMsgBoxWindow : TWindow {

    private void openYNCMessageBox() {
	application.messageBox("Yes/No/Cancel MessageBox",
	    q"EOS
This is an example of a Yes/No/Cancel MessageBox.

Note that the MessageBox text can span multiple
lines.

The default result (if someone hits the top-left
close button) is CANCEL.
EOS",
	TMessageBox.Type.YESNOCANCEL);
    }

    private void openYNMessageBox() {
	application.messageBox("Yes/No MessageBox",
	    q"EOS
This is an example of a Yes/No MessageBox.

Note that the MessageBox text can span multiple
lines.

The default result (if someone hits the top-left
close button) is NO.
EOS",
	TMessageBox.Type.YESNO);
    }

    private void openOKCMessageBox() {
	application.messageBox("OK/Cancel MessageBox",
	    q"EOS
This is an example of a OK/Cancel MessageBox.

Note that the MessageBox text can span multiple
lines.

The default result (if someone hits the top-left
close button) is CANCEL.
EOS",
	TMessageBox.Type.OKCANCEL);
    }

    private void openOKMessageBox() {
	application.messageBox("OK MessageBox",
	    q"EOS
This is an example of a OK MessageBox.  This is the
default MessageBox.

Note that the MessageBox text can span multiple
lines.

The default result (if someone hits the top-left
close button) is OK.
EOS",
	TMessageBox.Type.OK);
    }

    /// Constructor
    this(TApplication parent) {
	this(parent, TWindow.Flag.CENTERED | TWindow.Flag.RESIZABLE);
    }

    /// Constructor
    this(TApplication parent, Flag flags) {
	// Construct a demo window.  X and Y don't matter because it
	// will be centered on screen.
	super(parent, "Message Boxes", 0, 0, 60, 15, flags);

	uint row = 1;

	// Add some widgets
	addLabel("Default OK message box", 1, row);
	addButton("Open O&K MB", 35, row, &openOKMessageBox);
	row += 2;

	addLabel("OK/Cancel message box", 1, row);
	addButton("O&pen OKC MB", 35, row, &openOKCMessageBox);
	row += 2;

	addLabel("Yes/No message box", 1, row);
	addButton("Open &YN MB", 35, row, &openYNMessageBox);
	row += 2;

	addLabel("Yes/No/Cancel message box", 1, row);
	addButton("Ope&n YNC MB", 35, row, &openYNCMessageBox);
	row += 2;

	addLabel("Input box", 1, row);
	addButton("Open &input box", 35, row,
	    {
		application.inputBox("Input Box",
	    q"EOS
This is an example of an InputBox.

Note that the InputBox text can span multiple
lines.
EOS",
		    "some input text");
	    }
	);

	addButton("&Close Window", (width - 14) / 2, height - 4,
	    {
		application.closeWindow(this);
	    }
	);
    }

}

private class DemoMainWindow : TWindow {
    // Timer that increments a number
    private TTimer timer;

    // The modal window is a more low-level example of controlling a window
    // "from the outside".  Most windows will probably subclass TWindow and
    // do this kind of logic on their own.
    private TWindow modalWindow;
    private void openModalWindow() {
	modalWindow = application.addWindow("Demo Modal Window", 0, 0,
	    58, 15, TWindow.Flag.MODAL);
	modalWindow.addLabel("This is an example of a very braindead modal window.", 1, 1);
	modalWindow.addLabel("Modal windows are centered by default.", 1, 2);
	modalWindow.addButton("&Close", (modalWindow.width - 8)/2,
	    modalWindow.height - 4, &modalWindowClose);
    }
    private void modalWindowClose() {
	application.closeWindow(modalWindow);
    }

    /// This is an example of having a button call a function.
    private void openCheckboxWindow() {
	new DemoCheckboxWindow(application);
    }

    /// We need to override onClose so that the timer will no longer be
    /// called after we close the window.  TTimers currently are completely
    /// unaware of the rest of the UI classes.
    override public void onClose() {
	application.removeTimer(timer);
    }

    /// Constructor
    this(TApplication parent) {
	this(parent, TWindow.Flag.CENTERED | TWindow.Flag.RESIZABLE);
    }

    /// Constructor
    this(TApplication parent, Flag flags) {
	// Construct a demo window.  X and Y don't matter because it
	// will be centered on screen.
	super(parent, "Demo Window", 0, 0, 60, 23, flags);

	uint row = 1;

	// Add some widgets
	if (!isModal) {
	    addLabel("Message Boxes", 1, row);
	    addButton("&MessageBoxes", 35, row,
		{
		    new DemoMsgBoxWindow(application);
		}
	    );
	}
	row += 2;

	addLabel("Open me as modal", 1, row);
	addButton("W&indow", 35, row,
	    {
		new DemoMainWindow(application, Flag.MODAL);
	    }
	);

	row += 2;

	addLabel("Variable-width text field:", 1, row);
	addField(35, row++, 15, false, "Field text");

	addLabel("Fixed-width text field:", 1, row);
	addField(35, row, 15, true);
	row += 2;

	if (!isModal) {
	    addLabel("Radio buttons and checkboxes", 1, row);
	    addButton("&Checkboxes", 35, row, &openCheckboxWindow);
	}
	row += 2;

	if (!isModal) {
	    addLabel("Editor window", 1, row);
	    addButton("Edito&r", 35, row,
		{
		    new TEditor(application, 0, 0, 60, 15);
		}
	    );
	}
	row += 2;

	if (!isModal) {
	    addLabel("Text areas", 1, row);
	    addButton("&Text", 35, row,
		{
		    new DemoTextWindow(application);
		}
	    );
	}
	row += 2;

	if (!isModal) {
	    addLabel("Tree views", 1, row);
	    addButton("Tree&View", 35, row,
		{
		    new DemoTreeViewWindow(application);
		}
	    );
	}
	row += 2;

	version(Posix) {
	    if (!isModal) {
		addLabel("Terminal", 1, row);
		addButton("Termi&nal", 35, row,
		    {
			application.openTerminal(0, 0);
		    }
		);
	    }
	    row += 2;
	}

	TProgressBar bar = addProgressBar(1, row, 22);
	row++;
	TLabel timerLabel = addLabel("Timer", 1, row);
	timer = parent.addTimer(100,
	    {
		static int i = 0;
		auto writer = appender!dstring();
		formattedWrite(writer, "Timer: %d", i);
		timerLabel.text = writer.data;
		timerLabel.width = cast(uint)timerLabel.text.length;
		if (i < 100) {
		    i++;
		}
		bar.value = i;
		parent.repaint = true;
	    }, true);
    }

}

private class DemoApplication : TApplication {

    /// Constructor
    this() {
	super();
	new DemoMainWindow(this);

	// Add the menus
	addFileMenu();
	addEditMenu();

	TMenu demoMenu = addMenu("&Demo");
	TMenuItem item = demoMenu.addItem(2000, "&Checkable");
	item.checkable = true;
	item = demoMenu.addItem(2001, "Disabled");
	item.enabled = false;
	item = demoMenu.addItem(2002, "&Normal");
	TSubMenu subMenu = demoMenu.addSubMenu("Sub-&Menu");
	item = demoMenu.addItem(2010, "N&ormal A&&D");

	item = subMenu.addItem(2000, "&Checkable (sub)");
	item.checkable = true;
	item = subMenu.addItem(2001, "Disabled (sub)");
	item.enabled = false;
	item = subMenu.addItem(2002, "&Normal (sub)");

	subMenu = subMenu.addSubMenu("Sub-&Menu");
	item = subMenu.addItem(2000, "&Checkable (sub)");
	item.checkable = true;
	item = subMenu.addItem(2001, "Disabled (sub)");
	item.enabled = false;
	item = subMenu.addItem(2002, "&Normal (sub)");

	addWindowMenu();
    }

    /**
     * Handle menu events.
     *
     * Params:
     *    menu = menu event
     */
    override protected bool onMenu(TMenuEvent menu) {
	if (menu.id == TMenu.MID_OPEN_FILE) {
	    dstring filename = fileOpenBox(".");
	    if (filename !is null) {
		addEditor(filename);
	    }
	    return true;
	}

	return super.onMenu(menu);
    }

}

public void main(string [] args) {
    DemoApplication app = new DemoApplication();
    app.run();
}
