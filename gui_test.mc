// gui_test.mc - MimerCode GUI demo with theme-aware dialog
// Copyright 2026 Components4Developers - Kim Bo Madsen

// Modal dialog with callback prop.
// Uses theme color references so it adapts to Dark/Light theme.
view ConfirmDialog
  props
    Title: default "Confirm" String,
    Message: default "Are you sure?" String,
    OnConfirm: optional Callback
  end

  func HandleYes()
    if OnConfirm <> nil then
      OnConfirm()
    end
    Navigate.Dismiss()
  end

  func HandleNo()
    Navigate.Dismiss()
  end

  render
    vbox justify: "center", align: "center"
      vbox padding: 32, gap: 16, width: 400,
        background: "surface", radius: 8,
        border_color: "border", border_width: 1
        label text: Title, foreground: "text"
        end
        label text: Message, foreground: "text_muted"
        end
        hbox gap: 8, justify: "end"
          button text: "No", on_click: HandleNo
          end
          button text: "Yes", on_click: HandleYes
          end
        end
      end
    end
  end
end

// Detail view
view Detail
  props
    Message: default "Hello from Detail" String
  end

  func GoBack()
    Navigate.Pop()
  end

  render
    vbox padding: 24, gap: 16
      label text: "Detail View"
      end
      label text: Message
      end
      button text: "Back", on_click: GoBack
      end
    end
  end
end

// Main counter view with theme toggle
view Counter
  props
    Title: default "Counter" String
  end

  state
    Count: Integer := 0,
    IsDark: Boolean := true
  end

  func Increment()
    Count := Count + 1
  end

  func Decrement()
    if Count > 0 then
      Count := Count - 1
    end
  end

  func ShowDetail()
    Navigate.Push(Detail { Message: f"Count is {Count}" })
  end

  func DoReset()
    Count := 0
  end

  func ShowConfirm()
    Navigate.Show(ConfirmDialog {
      Title: "Reset Counter?",
      Message: f"Current count is {Count}. Reset to 0?",
      OnConfirm: DoReset
    })
  end

  func ToggleTheme()
    if IsDark then
      Navigate.SetTheme("Light")
      IsDark := false
    else
      Navigate.SetTheme("Dark")
      IsDark := true
    end
  end

  render
    vbox padding: 16, gap: 8
      label text: Title
      end
      label text: f"Count: {Count}"
      end
      hbox gap: 8
        button text: "-", on_click: Decrement
        end
        button text: "+", on_click: Increment
        end
        button text: "Detail", on_click: ShowDetail
        end
        button text: "Reset...", on_click: ShowConfirm
        end
        button text: "Theme", on_click: ToggleTheme
        end
      end
    end
  end
end

local App := serve("gui://")
App.Title("MimerCode Counter Demo")
App.Mount(Counter { Title: "My Counter" })
