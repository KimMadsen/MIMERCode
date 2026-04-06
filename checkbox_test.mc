// checkbox_test.mc - Checkbox, Radio, Switch demonstration
// Copyright 2026 Components4Developers - Kim Bo Madsen

view ControlsDemo
  state
    DarkMode: Boolean := true,
    Notifications: Boolean := true,
    AutoSave: Boolean := false,
    ShowLineNumbers: Boolean := true,
    FontSize: String := "medium",
    StatusText: String := "Ready"
  end

  func HandleDarkMode(V)
    DarkMode := V
    if V then
      StatusText := "Dark mode enabled"
    else
      StatusText := "Light mode enabled"
    end
  end

  func HandleNotifications(V)
    Notifications := V
    StatusText := f"Notifications: {V}"
  end

  func HandleAutoSave(V)
    AutoSave := V
    StatusText := f"Auto-save: {V}"
  end

  func HandleLineNumbers(V)
    ShowLineNumbers := V
    StatusText := f"Line numbers: {V}"
  end

  func HandleFontSmall(V)
    FontSize := "small"
    StatusText := "Font size: Small"
  end

  func HandleFontMedium(V)
    FontSize := "medium"
    StatusText := "Font size: Medium"
  end

  func HandleFontLarge(V)
    FontSize := "large"
    StatusText := "Font size: Large"
  end

  render
    vbox flex: 1, padding: 20, gap: 16
      label text: "Settings", font_size: 20, foreground: "primary"
      end

      // Switches section
      vbox gap: 8
        label text: "Appearance", font_size: 14, foreground: "text_muted"
        end
        switch text: "Dark Mode", checked: DarkMode,
          on_change: HandleDarkMode
        end
        switch text: "Show Notifications", checked: Notifications,
          on_change: HandleNotifications
        end
        switch text: "Auto-save", checked: AutoSave,
          on_change: HandleAutoSave
        end
      end

      separator
      end

      // Checkboxes section
      vbox gap: 8
        label text: "Editor Options", font_size: 14, foreground: "text_muted"
        end
        checkbox text: "Show line numbers", checked: ShowLineNumbers,
          on_change: HandleLineNumbers
        end
        checkbox text: "Word wrap", checked: false
        end
        checkbox text: "Highlight current line", checked: true
        end
        checkbox text: "Show minimap", checked: false
        end
      end

      separator
      end

      // Radio buttons section - inline expressions work in props
      vbox gap: 8
        label text: "Font Size", font_size: 14, foreground: "text_muted"
        end
        radio text: "Small (12px)", group: "fontsize",
          checked: FontSize = "small",
          on_change: HandleFontSmall
        end
        radio text: "Medium (14px)", group: "fontsize",
          checked: FontSize = "medium",
          on_change: HandleFontMedium
        end
        radio text: "Large (16px)", group: "fontsize",
          checked: FontSize = "large",
          on_change: HandleFontLarge
        end
      end

      spacer
      end

      // Status
      statusbar
        label text: StatusText
        end
        spacer
        end
        label text: f"Font: {FontSize}"
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Checkbox + Radio + Switch Demo",
  width: 500,
  height: 600
)
App.Mount("ControlsDemo")
