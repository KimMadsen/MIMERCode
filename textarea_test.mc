// textarea_test.mc - Test MimerCode textarea primitive
// Copyright 2026 Components4Developers - Kim Bo Madsen

// =============================================
// 1. Simple notepad - plain textarea, no extras
// =============================================

view Notepad
  state
    Content: String := "Hello World!\nThis is a simple notepad.\nType anything here.",
    StatusMsg: String := "Ready"
  end

  func HandleChange(V: String)
    Content := V
    StatusMsg := f"Length: {Length(V)}"
  end

  func HandleClear()
    Content := ""
    StatusMsg := "Cleared"
  end

  render
    vbox padding: 16, gap: 8, flex: 1
      label text: "Simple Notepad"
      end
      textarea value: Content, flex: 1,
        placeholder: "Type here...",
        on_change: HandleChange
      end
      hbox gap: 8
        label text: StatusMsg, flex: 1
        end
        button text: "Clear", on_click: HandleClear
        end
      end
    end
  end
end

// =============================================
// 2. Code editor - monospace with line numbers
// =============================================

view CodeEditor
  state
    Source: String := "// MimerCode example\nfunc Greet(Name: String)\n    return f\"Hello, {Name}!\"\nend\n\nWriteLn(Greet(\"World\"))",
    Output: String := "",
    LineInfo: String := "Ln 1, Col 0"
  end

  func HandleSourceChange(V: String)
    Source := V
  end

  func HandleRun()
    Output := "Running...\n(Execution not wired yet)"
  end

  func HandleClearOutput()
    Output := ""
  end

  render
    vbox padding: 12, gap: 8, flex: 1
      label text: "Code Editor"
      end
      hbox gap: 4
        button text: "Run (Ctrl+Enter)", on_click: HandleRun
        end
        button text: "Clear Output", on_click: HandleClearOutput
        end
      end
      // Code editor with line numbers and monospace font
      textarea value: Source, flex: 3,
        font: "mono",
        line_numbers: true,
        tab_size: 4,
        on_change: HandleSourceChange,
        on_submit: func(V) Output := "Running...\n(Ctrl+Enter pressed)" end
      end
      // Output area - read-only, no line numbers
      textarea value: Output, flex: 1,
        font: "mono",
        read_only: true,
        placeholder: "Output will appear here..."
      end
    end
  end
end

// =============================================
// 3. Main app with view switching
// =============================================

view Main
  state
    CurrentView: String := "notepad"
  end

  func ShowNotepad()
    CurrentView := "notepad"
  end

  func ShowEditor()
    CurrentView := "editor"
  end

  render
    vbox flex: 1
      hbox gap: 8, padding: 8
        button text: "Notepad", on_click: ShowNotepad
        end
        button text: "Code Editor", on_click: ShowEditor
        end
      end
      separator
      end
      if CurrentView = "notepad" then
        Notepad flex: 1
        end
      else
        CodeEditor flex: 1
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Textarea Test",
  width: 900,
  height: 700
)
App.Mount(Main {})
