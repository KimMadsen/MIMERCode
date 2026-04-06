// tree_test.mc - Tree, Toolbar, Statusbar demonstration
// Copyright 2026 Components4Developers - Kim Bo Madsen

view TreeDemo
  state
    SelectedFile: String := "",
    StatusText: String := "Ready",
    ItemCount: Integer := 0
  end

  func HandleSelect(Ev)
    SelectedFile := Ev["text"]
    StatusText := f"Selected: {Ev['text']} (index {Ev['index']})"
  end

  func HandleActivate(Ev)
    StatusText := f"Activated: {Ev}"
  end

  func HandleNew()
    StatusText := "New file..."
  end

  func HandleOpen()
    StatusText := "Open file..."
  end

  func HandleSave()
    StatusText := "Saving..."
  end

  func HandleRun()
    StatusText := "Running..."
  end

  render
    vbox flex: 1
      // Toolbar
      toolbar
        button text: "New", on_click: HandleNew
        end
        button text: "Open", on_click: HandleOpen
        end
        button text: "Save", on_click: HandleSave
        end
        separator
        end
        button text: "Run", on_click: HandleRun
        end
        spacer
        end
        label text: "MimerCode IDE"
        end
      end

      // Main content area with splitter
      splitter flex: 1, direction: "horizontal"
        // Left: tree view
        tree width: 250, on_select: HandleSelect, on_submit: HandleActivate,
             show_icons: true, indent: 22
          treeitem text: "project", expanded: true
            treeitem text: "src", expanded: true
              treeitem text: "main.mc"
              end
              treeitem text: "utils.mc"
              end
              treeitem text: "config.mc"
              end
            end
            treeitem text: "lib", expanded: false
              treeitem text: "math.mc"
              end
              treeitem text: "strings.mc"
              end
              treeitem text: "http.mc"
              end
              treeitem text: "linalg.mc"
              end
            end
            treeitem text: "tests"
              treeitem text: "test_math.mc"
              end
              treeitem text: "test_strings.mc"
              end
              treeitem text: "test_http.mc"
              end
            end
            treeitem text: "docs", expanded: false
              treeitem text: "README.md"
              end
              treeitem text: "CHANGELOG.md"
              end
              treeitem text: "API.md"
              end
            end
            treeitem text: "mimercode.toml"
            end
            treeitem text: ".gitignore"
            end
          end
        end

        // Right: editor area placeholder
        vbox flex: 1
          label text: f"Editing: {SelectedFile}", padding: 8, foreground: "text_muted"
          end
          textarea flex: 1, font: "mono", line_numbers: true,
            value: "// Select a file from the tree\n// Double-click to activate\n// Use arrow keys to navigate\n//   Left = collapse / go to parent\n//   Right = expand / go to child\n//   Enter = toggle expand or activate"
          end
        end
      end

      // Statusbar
      statusbar
        label text: StatusText
        end
        spacer
        end
        label text: "Ln 1, Col 1"
        end
        separator
        end
        label text: "MimerCode"
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Tree + Toolbar + Statusbar Demo",
  width: 900,
  height: 600
)
App.Mount("TreeDemo")
