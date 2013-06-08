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

            // Create a menu with Open and Exit actions
            TMenu menu = addMenu("&File");
            menu.addItem("&Open", cmOpen, kbAltO);
            menu.addItem("E&xit", cmExit, kbAltX);

            // Add the Edit menu
            editor.addMenu(this);
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

- [ ] Demo
  - [ ] Add editor window
- [ ] TText
  - [ ] Horizontal scrollbar
  - [ ] Vertical scrollbar
- [ ] TProgressBar
- [ ] TMenu / TMenuItem
  - [ ] TSubMenu
  - [ ] TMenuItem: enabled, disabled, checked, unchecked
- [ ] TButton: enabled, disabled
- [ ] TWindow
  - [ ] Horizontal scrollbar
  - [ ] Vertical scrollbar
  - [ ] Dispatch window resize events to children
- [ ] TFileOpenDialog
- [ ] TApplicationSocket - socket that knows about environment variables and
        rows X cols
      - [ ] this(TApplication application)
- [ ] TEditor : TWindow
- [ ] TTerminal

Wishlist features:

- [ ] Terminal
  - [ ] Mouse 1006 mode parsing
  - [ ] Win32 console support
- [ ] TWindow
  - [ ] SMARTPLACE (use smart placement for x, y)
  - [ ] &Window menu with Cascade, Tile, Close, Switch, etc.
- [ ] Screen
  - [ ] allow complex characters in putCharXY() and detect them in putStrXY().
- [ ] Drag and drop / copy and paste
  - [ ] TTextArea
  - [ ] TField
  - [ ] TText
