// splitter_test.mc - Test MimerCode splitter primitive
// Copyright 2026 Components4Developers - Kim Bo Madsen

// =============================================
// 1. Simple horizontal splitter
// =============================================

view SimpleHSplit
  state
    LeftText: String := "Left pane content.\nResize by dragging the divider.",
    RightText: String := "Right pane content.\nThis side grows and shrinks."
  end

  render
    splitter direction: "horizontal", flex: 1
      vbox padding: 12, flex: 1, min_width: 100, background: "surface"
        label text: "Left Panel"
        end
        label text: LeftText, foreground: "text_muted"
        end
      end
      vbox padding: 12, flex: 2, min_width: 100
        label text: "Right Panel"
        end
        label text: RightText, foreground: "text_muted"
        end
      end
    end
  end
end

// =============================================
// 2. Vertical splitter (top/bottom)
// =============================================

view SimpleVSplit
  state
    TopText: String := "Top pane - drag the handle below to resize.",
    BottomText: String := "Bottom pane - this is the output area."
  end

  render
    splitter direction: "vertical", flex: 1
      vbox padding: 12, flex: 3, min_height: 60, background: "surface"
        label text: "Editor Area"
        end
        label text: TopText, foreground: "text_muted"
        end
      end
      vbox padding: 12, flex: 1, min_height: 40
        label text: "Output Area"
        end
        label text: BottomText, foreground: "text_muted"
        end
      end
    end
  end
end

// =============================================
// 3. Nested splitters - IDE-like layout
// =============================================

view IDELayout
  state
    Source: String := "// MimerCode example\nfunc Greet(Name: String)\n    return f\"Hello, {Name}!\"\nend\n\nWriteLn(Greet(\"World\"))",
    Output: String := "",
    FileName: String := "untitled.mc",
    SplitInfo: String := "Drag any divider to resize"
  end

  func HandleRun()
    Output := "Running...\n> Hello, World!\n\nExecution complete."
  end

  func HandleClearOutput()
    Output := ""
  end

  func HandleSourceChange(V: String)
    Source := V
  end

  func HandleHSplitResize(Pos: String)
    SplitInfo := f"H-split at {Pos}px"
  end

  func HandleVSplitResize(Pos: String)
    SplitInfo := f"V-split at {Pos}px"
  end

  render
    vbox flex: 1
      // Toolbar
      hbox gap: 8, padding: 8, background: "surface"
        button text: "Run", on_click: HandleRun
        end
        button text: "Clear Output", on_click: HandleClearOutput
        end
        spacer
        end
        label text: SplitInfo, foreground: "text_muted"
        end
      end
      separator
      end
      // Main content: horizontal split (file list | editor+output)
      splitter direction: "horizontal", flex: 1,
        on_resize: HandleHSplitResize
        // Left: file list placeholder
        vbox width: 180, min_width: 100, padding: 8, background: "surface"
          label text: "Files"
          end
          separator
          end
          label text: "untitled.mc", foreground: "text_muted"
          end
          label text: "demo.mc", foreground: "text_muted"
          end
          label text: "hello.mc", foreground: "text_muted"
          end
        end
        // Right: vertical split (editor | output)
        splitter direction: "vertical", flex: 1,
          on_resize: HandleVSplitResize
          textarea value: Source, flex: 3, font: "mono",
            line_numbers: true, tab_size: 4,
            on_change: HandleSourceChange
          end
          textarea value: Output, flex: 1, font: "mono",
            read_only: true,
            placeholder: "Output will appear here..."
          end
        end
      end
    end
  end
end

// =============================================
// Main: view switcher
// =============================================

view Main
  state
    CurrentView: String := "ide"
  end

  func ShowHSplit()
    CurrentView := "hsplit"
  end

  func ShowVSplit()
    CurrentView := "vsplit"
  end

  func ShowIDE()
    CurrentView := "ide"
  end

  render
    vbox flex: 1
      hbox gap: 8, padding: 8
        button text: "H-Split", on_click: ShowHSplit
        end
        button text: "V-Split", on_click: ShowVSplit
        end
        button text: "IDE Layout", on_click: ShowIDE
        end
        label text: f"Current: {CurrentView}"
        end
      end
      separator
      end
      if CurrentView = "hsplit" then
        SimpleHSplit flex: 1
        end
      elif CurrentView = "vsplit" then
        SimpleVSplit flex: 1
        end
      else
        IDELayout flex: 1
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Splitter Test",
  width: 1000,
  height: 700
)
App.Mount(Main {})
