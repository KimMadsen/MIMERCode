// select_test.mc - Dropdown Select and Combobox demonstration
// Copyright 2026 Components4Developers - Kim Bo Madsen

view SelectDemo
  state
    SelectedColor: String := "Blue",
    SelectedFont: String := "",
    SelectedCountry: String := "",
    SelectedDeptId: Integer := 0,
    SelectedPriorityId: String := "",
    StatusText: String := "Ready"
  end

  func HandleColorChange(V)
    SelectedColor := V
    StatusText := f"Color changed to: {V}"
  end

  func HandleFontChange(V)
    SelectedFont := V
    StatusText := f"Font selected: {V}"
  end

  func HandleCountryChange(V)
    SelectedCountry := V
    StatusText := f"Country selected: {V}"
  end

  func HandleDeptChange(V)
    SelectedDeptId := int(V)
    StatusText := f"Department ID changed to: {V}"
  end

  func HandlePriorityChange(V)
    SelectedPriorityId := V
    StatusText := f"Priority changed to key: {V}"
  end

  render
    vbox flex: 1, padding: 20, gap: 20
      label text: "Dropdown & Combobox", font_size: 20, foreground: "primary"
      end

      hbox gap: 20, flex: 1
        // Left column: simple mode
        vbox gap: 16, flex: 1
          label text: "Simple Mode", font_size: 14, foreground: "text_muted",
            font_weight: "bold"
          end

          // Select (dropdown)
          vbox gap: 6
            label text: "Favorite Color", font_size: 12, foreground: "text_muted"
            end
            select value: SelectedColor,
              placeholder: "Pick a color...",
              options: ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"],
              on_change: HandleColorChange
            end
          end

          // Select with many options (scrollable)
          vbox gap: 6
            label text: "Country", font_size: 12, foreground: "text_muted"
            end
            select value: SelectedCountry,
              placeholder: "Select country...",
              max_visible: 6,
              options: ["Argentina", "Australia", "Austria", "Belgium", "Brazil",
                        "Canada", "Chile", "China", "Colombia", "Denmark",
                        "Egypt", "Finland", "France", "Germany", "Greece",
                        "India", "Ireland", "Italy", "Japan", "Mexico",
                        "Netherlands", "New Zealand", "Norway", "Poland",
                        "Portugal", "South Korea", "Spain", "Sweden",
                        "Switzerland", "United Kingdom", "United States"],
              on_change: HandleCountryChange
            end
          end

          // Combobox (type to filter)
          vbox gap: 6
            label text: "Font Family (type to filter)", font_size: 12, foreground: "text_muted"
            end
            combobox value: SelectedFont,
              placeholder: "Type or select a font...",
              max_visible: 6,
              options: ["Arial", "Calibri", "Cambria", "Consolas", "Courier New",
                        "Georgia", "Helvetica", "Impact", "Lucida Console",
                        "Monaco", "Palatino", "Segoe UI", "Tahoma",
                        "Times New Roman", "Trebuchet MS", "Verdana"],
              on_change: HandleFontChange
            end
          end
        end

        // Right column: lookup mode (key/value)
        vbox gap: 16, flex: 1
          label text: "Lookup Mode (key/value)", font_size: 14, foreground: "text_muted",
            font_weight: "bold"
          end

          // Lookup select: value holds the key, display shows the value
          vbox gap: 6
            label text: "Department (lookup select)", font_size: 12, foreground: "text_muted"
            end
            select value: SelectedDeptId,
              placeholder: "Select department...",
              options: [
                dict{"key": 1, "value": "Engineering"},
                dict{"key": 2, "value": "Sales"},
                dict{"key": 3, "value": "Marketing"},
                dict{"key": 4, "value": "Human Resources"},
                dict{"key": 5, "value": "Finance"},
                dict{"key": 6, "value": "Legal"}
              ],
              on_change: HandleDeptChange
            end
            label text: f"Bound variable holds key: {SelectedDeptId}",
              font_size: 11, foreground: "text_muted"
            end
          end

          // Lookup combobox: type to search by value, stores key
          vbox gap: 6
            label text: "Priority (lookup combobox)", font_size: 12, foreground: "text_muted"
            end
            combobox value: SelectedPriorityId,
              placeholder: "Type to search priorities...",
              options: [
                dict{"key": "P1", "value": "Critical - Immediate action"},
                dict{"key": "P2", "value": "High - Within 24 hours"},
                dict{"key": "P3", "value": "Medium - This week"},
                dict{"key": "P4", "value": "Low - When possible"},
                dict{"key": "P5", "value": "Wishlist - Future consideration"}
              ],
              on_change: HandlePriorityChange
            end
            label text: f"Bound variable holds key: {SelectedPriorityId}",
              font_size: 11, foreground: "text_muted"
            end
          end
        end
      end

      spacer
      end

      // Status display
      vbox gap: 4, padding: 12, background: "surface", radius: 6
        label text: StatusText
        end
        label text: f"Color: {SelectedColor}  |  Font: {SelectedFont}  |  DeptId: {SelectedDeptId}  |  Priority: {SelectedPriorityId}",
          foreground: "text_muted", font_size: 12
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Select + Combobox Demo (with Lookup)",
  width: 700,
  height: 600
)
App.Mount("SelectDemo")
