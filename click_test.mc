// click_test.mc - Minimal click test
// Copyright 2026 Components4Developers - Kim Bo Madsen

view Main
  state
    Log: String := "Click any item"
  end

  func HandleClick(Name)
    Log := f"Clicked: {Name}"
  end

  render
    vbox flex: 1, padding: 16, gap: 8
      label text: Log
      end
      separator
      end
      hbox padding: 8, background: "#333333",
        on_click: func() Log := "Clicked hbox directly" end
        label text: "Click this hbox"
        end
      end
      separator
      end
      scroll flex: 1, padding: 4, gap: 2, selectable: true
        hbox padding: 8, background: "#333333",
          on_click: func() Log := "Item 1" end
          label text: "Item 1 (hbox in scroll)"
          end
        end
        hbox padding: 8, background: "#333333",
          on_click: func() Log := "Item 2" end
          label text: "Item 2 (hbox in scroll)"
          end
        end
        hbox padding: 8, background: "#333333",
          on_click: func() Log := "Item 3" end
          label text: "Item 3 (hbox in scroll)"
          end
        end
      end
    end
  end
end

local App := serve("gui://")
App.Title("Click Test")
App.Mount("Main")
