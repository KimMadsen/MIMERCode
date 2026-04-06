// custom_view_switch_test.mc - Minimal test for if/else custom view switching
// Copyright 2026 Components4Developers - Kim Bo Madsen

view ViewA
  render
    vbox padding: 16, flex: 1, background: "#2d4a2d"
      label text: "This is View A"
      end
      label text: "It has a green background"
      end
    end
  end
end

view ViewB
  render
    vbox padding: 16, flex: 1, background: "#4a2d2d"
      label text: "This is View B"
      end
      label text: "It has a red background"
      end
    end
  end
end

view Main
  state
    Current: String := "a"
  end

  func ShowA()
    Current := "a"
  end

  func ShowB()
    Current := "b"
  end

  render
    vbox flex: 1
      hbox gap: 8, padding: 8
        button text: "Show A", on_click: ShowA
        end
        button text: "Show B", on_click: ShowB
        end
        label text: f"Current: {Current}"
        end
      end
      separator
      end
      if Current = "a" then
        ViewA flex: 1
        end
      else
        ViewB flex: 1
        end
      end
    end
  end
end

local App := serve("gui://")
App.Title("Custom View Switch Test")
App.Mount(Main {})
