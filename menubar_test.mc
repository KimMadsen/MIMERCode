// menubar_test.mc - Test menus, submenus, and popup menus
// Copyright 2026 Components4Developers - Kim Bo Madsen

view Main
  state
    Log: String := "Ready",
    Content: String := "Right-click here for context menu",
    ShowPopup: Boolean := false,
    PopX: Integer := 0,
    PopY: Integer := 0
  end

  func HandleNew()
    Log := "File > New"
  end
  func HandleOpen()
    Log := "File > Open"
  end
  func HandleRecent1()
    Log := "File > Open Recent > project1.mc"
  end
  func HandleRecent2()
    Log := "File > Open Recent > project2.mc"
  end
  func HandleRecent3()
    Log := "File > Open Recent > project3.mc"
  end
  func HandleSave()
    Log := "File > Save"
  end
  func HandleExit()
    Log := "File > Exit"
  end
  func HandleUndo()
    Log := "Edit > Undo"
  end
  func HandleRedo()
    Log := "Edit > Redo"
  end
  func HandleCut()
    Log := "Edit > Cut"
  end
  func HandleCopy()
    Log := "Edit > Copy"
  end
  func HandlePaste()
    Log := "Edit > Paste"
  end
  func HandleUpper()
    Log := "Transform > Uppercase"
  end
  func HandleLower()
    Log := "Transform > Lowercase"
  end
  func HandleTrim()
    Log := "Transform > Trim"
  end
  func HandleRun()
    Log := "Run > Execute"
  end
  func HandleDebug()
    Log := "Run > Debug"
  end
  func HandleAbout()
    Log := "Help > About"
  end
  func HandleContext(Ev)
    PopX := Ev["x"]
    PopY := Ev["y"]
    ShowPopup := true
    Log := f"Context menu at ({PopX}, {PopY})"
  end
  func ClosePopup()
    ShowPopup := false
  end

  render
    vbox flex: 1
      menubar
        menu text: "File"
          menuitem text: "New", shortcut: "Ctrl+N", on_click: HandleNew
          end
          menuitem text: "Open...", shortcut: "Ctrl+O", on_click: HandleOpen
          end
          menu text: "Open Recent"
            menuitem text: "project1.mc", on_click: HandleRecent1
            end
            menuitem text: "project2.mc", on_click: HandleRecent2
            end
            menuitem text: "project3.mc", on_click: HandleRecent3
            end
          end
          separator
          end
          menuitem text: "Save", shortcut: "Ctrl+S", on_click: HandleSave
          end
          separator
          end
          menuitem text: "Exit", on_click: HandleExit
          end
        end
        menu text: "Edit"
          menuitem text: "Undo", shortcut: "Ctrl+Z", on_click: HandleUndo
          end
          menuitem text: "Redo", shortcut: "Ctrl+Y", on_click: HandleRedo
          end
          separator
          end
          menuitem text: "Cut", shortcut: "Ctrl+X", on_click: HandleCut
          end
          menuitem text: "Copy", shortcut: "Ctrl+C", on_click: HandleCopy
          end
          menuitem text: "Paste", shortcut: "Ctrl+V", on_click: HandlePaste
          end
          separator
          end
          menu text: "Transform"
            menuitem text: "Uppercase", on_click: HandleUpper
            end
            menuitem text: "Lowercase", on_click: HandleLower
            end
            menuitem text: "Trim Whitespace", on_click: HandleTrim
            end
          end
        end
        menu text: "Run"
          menuitem text: "Execute", shortcut: "F5", on_click: HandleRun
          end
          menuitem text: "Debug", shortcut: "F9", on_click: HandleDebug
          end
        end
        menu text: "Help"
          menuitem text: "About MimerCode", on_click: HandleAbout
          end
        end
      end
      vbox flex: 1, padding: 16, gap: 8,
        on_contextmenu: HandleContext
        hbox gap: 8
          label text: Content
          end
          button text: "Show Popup", on_click: func()
            PopX := 200
            PopY := 200
            ShowPopup := true
            Log := "Manual popup trigger"
          end
          end
        end
        label text: f"Last action: {Log}", foreground: "text_muted"
        end
      end
      popup visible: ShowPopup, popup_x: PopX, popup_y: PopY,
        on_popup_close: ClosePopup
        menuitem text: "Cut", shortcut: "Ctrl+X", on_click: HandleCut
        end
        menuitem text: "Copy", shortcut: "Ctrl+C", on_click: HandleCopy
        end
        menuitem text: "Paste", shortcut: "Ctrl+V", on_click: HandlePaste
        end
        separator
        end
        menu text: "Transform"
          menuitem text: "Uppercase", on_click: HandleUpper
          end
          menuitem text: "Lowercase", on_click: HandleLower
          end
        end
      end
    end
  end
end

local App := serve("gui://")
App.Title("Menu Test")
App.Mount("Main")
