D Text User Interface library
=============================

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

Win32 console support is desired, contributions to that effort would
be *greatly* appreciated.

License
-------

This library is licensed LGPL ("GNU Lesser General Public License")
version 3 or greater.  See the file COPYING for the full license text,
which includes both the GPL v3 and the LGPL supplemental terms.

Usage
-----

The library is currently under initial development, usage patterns are
still being worked on.  Generally the goal will be to build
applications somewhat as follows:

    import tui;

    public class MyApplication : TApplication {
        this() {
            super();
            // Create an editor window that has support for
            // copy/paste, search text, arrow keys, horizontal
            // and vertical scrollbar, etc.
            TEditor editor = new TEditor(this);

            // Create a menu
            TMenu menu = new TMenu(this);

            // Create a "File" menu with an Exit action
            TMenu fileMenu = menu.addMenu("&File");
            fileMenu.addItem("E&xit");

            // Add the Edit menu
            menu.addMenu(editor.getMenu());
        }
    }

    void main(string [] args) {
        MyApplication app = new MyApplication();
        app.run();
    }

See the file demo1.d for example usages.

Roadmap
-------

I am just beginning as a work in progress.  Many tasks remain before
calling this version 1.0:

- TApplication
  - [ ] Timers:
    - [ ] setTimer
    - [ ] getSleepTime
- TMenu / TMenuItem
  - [ ] submenus
  - [ ] active, inactive, checked, unchecked
  - [ ] Keyboard shortcut ("&File" or "~F~ile" ?)
  - [ ] Keyboard accelerator ("Ctrl-F10")
- TInputBox - simple method to grab a string
- Screen
  - [ ] putColorizedStrXY : colorized string markup style - use for highlights and general dialog boxes
  - [ ] allow complex characters in putCharXY() and detect them in putStrXY().
- TWindow
  - [ ] SMARTPLACE (use smart placement for x, y)
  - [ ] Horizontal scrollbar
  - [ ] Vertical scrollbar
  - [ ] Dispatch window resize events
- [ ] TTextArea
- [ ] TText
  - [ ] Reflows with window resize
- [ ] Drag and drop / copy and paste
  - [ ] TTextArea
  - [ ] TField
  - [ ] TText
- [ ] TFileOpenDialog
- [ ] TTerminal
- [ ] TApplicationSocket - socket that knows about environment variables and
        rows X cols
      - [ ] this(TApplication application)
- Terminal
  - [X] Mouse 1000 mode parsing
  - [ ] Mouse 1006 mode parsing
  - [ ] Win32 console support
