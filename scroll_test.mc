// scroll_test.mc - Test MimerCode scroll container
// Copyright 2026 Components4Developers - Kim Bo Madsen

// =============================================
// 1. Simple scroll with many items
// =============================================

view ItemList
  state
    ItemCount: Integer := 30,
    Selected: String := ""
  end

  func AddItems()
    ItemCount := ItemCount + 10
  end

  func RemoveItems()
    if ItemCount > 5 then
      ItemCount := ItemCount - 5
    end
  end

  render
    vbox flex: 1, padding: 8, gap: 8
      hbox gap: 8
        label text: f"Items: {ItemCount}"
        end
        button text: "+10", on_click: AddItems
        end
        button text: "-5", on_click: RemoveItems
        end
      end
      separator
      end
      scroll flex: 1, background: "surface", padding: 4, gap: 2,
        selectable: true
        for I := 0 to ItemCount - 1 do
          hbox padding: 8, gap: 8, key: f"item_{I}",
            radius: 4,
            background: "input_bg"
            label text: f"Item {I + 1}: Value {(I + 1) * 7}"
            end
          end
        end
      end
    end
  end
end

// =============================================
// 2. Scroll inside a splitter (IDE-like)
// =============================================

view FileList
  state
    Files: Array := ["main.mc", "utils.mc", "config.mc", "test.mc",
      "demo.mc", "hello.mc", "webapp.mc", "gui_test.mc",
      "oop_test.mc", "generics.mc", "sorting.mc", "strings.mc",
      "math.mc", "linalg.mc", "tuples.mc", "functional.mc",
      "contracts_test.mc", "template_test.mc", "pipeline_test.mc",
      "textarea_test.mc", "splitter_test.mc", "scroll_test.mc"],
    SelectedFile: String := "",
    SelectedIdx: Integer := -1
  end

  func HandleSelect(Idx: Integer, Name: String)
    SelectedIdx := Idx
    SelectedFile := Name
  end

  render
    vbox flex: 1
      hbox padding: 8
        label text: "Files", foreground: "text"
        end
        spacer
        end
        label text: f"{Length(Files)}", foreground: "text_muted"
        end
      end
      separator
      end
      scroll flex: 1, padding: 4, gap: 1,
        selectable: true, selected: SelectedIdx,
        id: "file_scroll"
        for I, F in Files do
          hbox padding: (4, 8), key: f"file_{I}", radius: 3,
            background: "input_bg",
            on_click: func() HandleSelect(I, F) end
            label text: F, foreground: "text"
            end
          end
        end
      end
      separator
      end
      hbox padding: 8
        label text: f"Selected: {SelectedFile}", foreground: "text_muted"
        end
      end
    end
  end
end

view IDEWithScroll
  state
    Source: String := "// Scroll test\nfunc Main()\n    WriteLn(\"Hello\")\nend\n"
  end

  func HandleChange(V: String)
    Source := V
  end

  render
    splitter direction: "horizontal", flex: 1
      FileList min_width: 120, flex: 1
      end
      textarea value: Source, flex: 3, font: "mono",
        line_numbers: true, tab_size: 4,
        on_change: HandleChange
      end
    end
  end
end

// =============================================
// 3. Complex card list
// =============================================

view CardList
  state
    SelectedIdx: Integer := -1,
    SelectedName: String := "(none)"
  end

  func HandleSelect(Idx: Integer, Name: String)
    SelectedIdx := Idx
    SelectedName := Name
  end

  render
    vbox flex: 1, padding: 8, gap: 8
      hbox gap: 8
        label text: "Team Members", foreground: "text"
        end
        spacer
        end
        label text: f"Selected: {SelectedName}", foreground: "primary",
          font_size: 13
        end
      end
      separator
      end
      scroll flex: 1, padding: 6, gap: 4,
        selectable: true, selected: SelectedIdx,
        background: "surface"

        // Alice - Lead Developer
        hbox padding: 12, gap: 12, key: "card_0", radius: 6,
          background: "input_bg",
          on_click: func() HandleSelect(0, "Alice") end
          vbox width: 40
            label text: "A", foreground: "primary",
              font_size: 24
            end
          end
          vbox flex: 1, gap: 2
            hbox gap: 8
              label text: "Alice Johnson", foreground: "text",
                font_size: 14
              end
              spacer
              end
              label text: "Lead Developer", foreground: "text_muted",
                font_size: 11
              end
            end
            label text: "Rust, Go, Python | 12 years exp",
              foreground: "text_muted", font_size: 11
            end
            hbox gap: 16
              label text: "PRs: 847", foreground: "text_muted",
                font_size: 11
              end
              label text: "Reviews: 1,203", foreground: "text_muted",
                font_size: 11
              end
              label text: "Commits: 3,491", foreground: "text_muted",
                font_size: 11
              end
            end
          end
        end

        // Bob - Backend Engineer
        hbox padding: 12, gap: 12, key: "card_1", radius: 6,
          background: "input_bg",
          on_click: func() HandleSelect(1, "Bob") end
          vbox width: 40
            label text: "B", foreground: "primary",
              font_size: 24
            end
          end
          vbox flex: 1, gap: 2
            hbox gap: 8
              label text: "Bob Smith", foreground: "text",
                font_size: 14
              end
              spacer
              end
              label text: "Backend Engineer", foreground: "text_muted",
                font_size: 11
              end
            end
            label text: "Java, Kotlin, SQL | 8 years exp",
              foreground: "text_muted", font_size: 11
            end
            hbox gap: 16
              label text: "PRs: 423", foreground: "text_muted",
                font_size: 11
              end
              label text: "Reviews: 612", foreground: "text_muted",
                font_size: 11
              end
              label text: "Commits: 1,847", foreground: "text_muted",
                font_size: 11
              end
            end
          end
        end

        // Carol - Frontend Lead
        hbox padding: 12, gap: 12, key: "card_2", radius: 6,
          background: "input_bg",
          on_click: func() HandleSelect(2, "Carol") end
          vbox width: 40
            label text: "C", foreground: "primary",
              font_size: 24
            end
          end
          vbox flex: 1, gap: 2
            hbox gap: 8
              label text: "Carol Williams", foreground: "text",
                font_size: 14
              end
              spacer
              end
              label text: "Frontend Lead", foreground: "text_muted",
                font_size: 11
              end
            end
            label text: "TypeScript, React, CSS | 10 years exp",
              foreground: "text_muted", font_size: 11
            end
            hbox gap: 16
              label text: "PRs: 691", foreground: "text_muted",
                font_size: 11
              end
              label text: "Reviews: 934", foreground: "text_muted",
                font_size: 11
              end
              label text: "Commits: 2,756", foreground: "text_muted",
                font_size: 11
              end
            end
          end
        end

        // Dave - DevOps
        hbox padding: 12, gap: 12, key: "card_3", radius: 6,
          background: "input_bg",
          on_click: func() HandleSelect(3, "Dave") end
          vbox width: 40
            label text: "D", foreground: "primary",
              font_size: 24
            end
          end
          vbox flex: 1, gap: 2
            hbox gap: 8
              label text: "Dave Brown", foreground: "text",
                font_size: 14
              end
              spacer
              end
              label text: "DevOps Engineer", foreground: "text_muted",
                font_size: 11
              end
            end
            label text: "Docker, K8s, Terraform | 6 years exp",
              foreground: "text_muted", font_size: 11
            end
            hbox gap: 16
              label text: "PRs: 312", foreground: "text_muted",
                font_size: 11
              end
              label text: "Reviews: 189", foreground: "text_muted",
                font_size: 11
              end
              label text: "Deploys: 1,423", foreground: "text_muted",
                font_size: 11
              end
            end
          end
        end

        // Eve - QA Lead
        hbox padding: 12, gap: 12, key: "card_4", radius: 6,
          background: "input_bg",
          on_click: func() HandleSelect(4, "Eve") end
          vbox width: 40
            label text: "E", foreground: "primary",
              font_size: 24
            end
          end
          vbox flex: 1, gap: 2
            hbox gap: 8
              label text: "Eve Davis", foreground: "text",
                font_size: 14
              end
              spacer
              end
              label text: "QA Lead", foreground: "text_muted",
                font_size: 11
              end
            end
            label text: "Selenium, Cypress, Jest | 7 years exp",
              foreground: "text_muted", font_size: 11
            end
            hbox gap: 16
              label text: "Tests: 4,891", foreground: "text_muted",
                font_size: 11
              end
              label text: "Bugs found: 723", foreground: "text_muted",
                font_size: 11
              end
              label text: "Coverage: 94%", foreground: "text_muted",
                font_size: 11
              end
            end
          end
        end

        // Frank - Data Scientist
        hbox padding: 12, gap: 12, key: "card_5", radius: 6,
          background: "input_bg",
          on_click: func() HandleSelect(5, "Frank") end
          vbox width: 40
            label text: "F", foreground: "primary",
              font_size: 24
            end
          end
          vbox flex: 1, gap: 2
            hbox gap: 8
              label text: "Frank Miller", foreground: "text",
                font_size: 14
              end
              spacer
              end
              label text: "Data Scientist", foreground: "text_muted",
                font_size: 11
              end
            end
            label text: "Python, R, TensorFlow | 5 years exp",
              foreground: "text_muted", font_size: 11
            end
            hbox gap: 16
              label text: "Models: 47", foreground: "text_muted",
                font_size: 11
              end
              label text: "Papers: 8", foreground: "text_muted",
                font_size: 11
              end
              label text: "Accuracy: 97.3%", foreground: "text_muted",
                font_size: 11
              end
            end
          end
        end

      end
      separator
      end
      hbox padding: 8
        label text: f"Selected: {SelectedName}", foreground: "primary",
          font_size: 13
        end
      end
    end
  end
end

// =============================================
// 4. Multi-select list
// =============================================

view MultiSelectList
  state
    SelectionInfo: String := "No selection",
    FileNames: Array := ["README.md", "package.json", "tsconfig.json",
      "src/main.ts", "src/config.ts", "src/utils.ts", "src/types.ts",
      "tests/main.test.ts", "tests/utils.test.ts", ".gitignore",
      ".eslintrc.json", "docker-compose.yml"],
    FileSizes: Array := ["2.4 KB", "1.1 KB", "0.8 KB", "12.3 KB",
      "3.7 KB", "5.2 KB", "8.1 KB", "6.9 KB", "4.3 KB", "0.2 KB",
      "0.5 KB", "1.8 KB"]
  end

  func HandleSelect(Indices: Array)
    if Length(Indices) = 0 then
      SelectionInfo := "No selection"
    elif Length(Indices) = 1 then
      SelectionInfo := f"Selected: {FileNames[Indices[0]]}"
    else
      local Names := ""
      for I, Idx in Indices do
        if I > 0 then
          Names := Names + ", "
        end
        Names := Names + FileNames[Idx]
      end
      SelectionInfo := f"Selected {Length(Indices)} files: {Names}"
    end
  end

  render
    vbox flex: 1, padding: 8, gap: 8
      hbox gap: 8
        label text: "Ctrl+click, Shift+click, Shift+arrows, Space to multi-select",
          foreground: "text"
        end
      end
      separator
      end
      scroll flex: 1, padding: 4, gap: 2, background: "surface",
        selectable: true, multi_select: true,
        on_select: func(Indices) HandleSelect(Indices) end
        for I, F in FileNames do
          hbox padding: (6, 10), key: f"ms_{I}", radius: 3, background: "input_bg"
            label text: F, foreground: "text"
            end
            spacer
            end
            label text: FileSizes[I], foreground: "text_muted", font_size: 11
            end
          end
        end
      end
      separator
      end
      hbox padding: 8
        label text: SelectionInfo, foreground: "primary", font_size: 13
        end
      end
    end
  end
end

// =============================================
// Main view switcher
// =============================================

view Main
  state
    CurrentView: String := "cards"
  end

  func ShowList()
    CurrentView := "list"
  end

  func ShowIDE()
    CurrentView := "ide"
  end

  func ShowCards()
    CurrentView := "cards"
  end

  func ShowMulti()
    CurrentView := "multi"
  end

  render
    vbox flex: 1
      hbox gap: 8, padding: 8
        button text: "Item List", on_click: ShowList
        end
        button text: "IDE + Scroll", on_click: ShowIDE
        end
        button text: "Card List", on_click: ShowCards
        end
        button text: "Multi-Select", on_click: ShowMulti
        end
        label text: f"Current: {CurrentView}"
        end
      end
      separator
      end
      if CurrentView = "list" then
        ItemList flex: 1
        end
      elif CurrentView = "ide" then
        IDEWithScroll flex: 1
        end
      elif CurrentView = "cards" then
        CardList flex: 1
        end
      elif CurrentView = "multi" then
        MultiSelectList flex: 1
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Scroll Test",
  width: 900,
  height: 700
)
App.Mount(Main {})
