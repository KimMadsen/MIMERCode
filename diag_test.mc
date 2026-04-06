// diag_test.mc - Minimal diagnostic for prop dispatch
// Copyright 2026 Components4Developers - Kim Bo Madsen

view Main
  state
    Log: String := "Click buttons to test",
    ShowPop: Boolean := true
  end

  func HandleA()
    Log := "Button A clicked"
  end

  render
    vbox flex: 1, padding: 16, gap: 8
      button text: "Button A", on_click: HandleA
      end
      button text: "Button B", on_click: func() Log := "Button B clicked" end
      end
      label text: Log
      end
      separator
      end
      label text: "Popup should be visible below:"
      end
      popup visible: ShowPop, popup_x: 50, popup_y: 250
        menuitem text: "Item One", on_click: func() Log := "Item One" end
        end
        menuitem text: "Item Two", on_click: func() Log := "Item Two" end
        end
      end
    end
  end
end

local App := serve("gui://")
App.Title("Diagnostic")
App.Mount("Main")
