// svg_test.mc - Icon and SVG rendering demonstration
// Copyright 2026 Components4Developers - Kim Bo Madsen

view SvgDemo
  state
    StatusText: String := "Hover over icons for tooltips"
  end

  render
    vbox flex: 1, padding: 20, gap: 16
      label text: "Icons & SVG", font_size: 20, foreground: "primary"
      end

      // Material Design Icons (inline SVG path data)
      vbox gap: 10
        label text: "Material Design Icons (path data)", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 16, align: "center"
          // Menu icon
          icon path: "M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z",
            size: 24, foreground: "text", tooltip: "Menu"
          end
          // Home icon
          icon path: "M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z",
            size: 24, foreground: "text", tooltip: "Home"
          end
          // Search icon
          icon path: "M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z",
            size: 24, foreground: "text", tooltip: "Search"
          end
          // Settings icon
          icon path: "M19.14 12.94c.04-.3.06-.61.06-.94 0-.32-.02-.64-.07-.94l2.03-1.58c.18-.14.23-.41.12-.61l-1.92-3.32c-.12-.22-.37-.29-.59-.22l-2.39.96c-.5-.38-1.03-.7-1.62-.94l-.36-2.54c-.04-.24-.24-.41-.48-.41h-3.84c-.24 0-.43.17-.47.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96c-.22-.08-.47 0-.59.22L2.74 8.87c-.12.21-.08.47.12.61l2.03 1.58c-.05.3-.07.62-.07.94s.02.64.07.94l-2.03 1.58c-.18.14-.23.41-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.38 1.03.7 1.62.94l.36 2.54c.05.24.24.41.48.41h3.84c.24 0 .44-.17.47-.41l.36-2.54c.59-.24 1.13-.56 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32c.12-.22.07-.47-.12-.61l-2.01-1.58zM12 15.6c-1.98 0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6 1.62 3.6 3.6-1.62 3.6-3.6 3.6z",
            size: 24, foreground: "text", tooltip: "Settings"
          end
          // Save icon
          icon path: "M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm-5 16c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-10H5V5h10v4z",
            size: 24, foreground: "text", tooltip: "Save"
          end
          // Play icon
          icon path: "M8 5v14l11-7z",
            size: 24, foreground: "primary", tooltip: "Play"
          end
          // Folder icon
          icon path: "M10 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2h-8l-2-2z",
            size: 24, foreground: "primary", tooltip: "Folder"
          end
          // File icon
          icon path: "M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z",
            size: 24, foreground: "text_muted", tooltip: "File"
          end
        end

        // Larger icons with different colors
        hbox gap: 20, align: "center"
          icon path: "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z",
            size: 40, foreground: "primary", tooltip: "Check Circle (40px)"
          end
          icon path: "M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z",
            size: 40, foreground: "#FF9800", tooltip: "Warning (40px)"
          end
          icon path: "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z",
            size: 40, foreground: "#F44336", tooltip: "Error (40px)"
          end
          icon path: "M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z",
            size: 40, foreground: "#FFC107", tooltip: "Star (40px)"
          end
        end
      end

      separator
      end

      // Inline SVG source
      vbox gap: 10
        label text: "Inline SVG (full XML source)", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 16
          // Simple geometric SVG
          svg width: 100, height: 100,
            source: "<svg viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'><circle cx='50' cy='50' r='45' fill='currentColor' opacity='0.2'/><circle cx='50' cy='50' r='30' fill='none' stroke='currentColor' stroke-width='3'/><circle cx='50' cy='50' r='15' fill='currentColor'/></svg>",
            foreground: "primary", tooltip: "Concentric circles"
          end

          // SVG with groups and transforms
          svg width: 100, height: 100,
            source: "<svg viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'><rect x='10' y='10' width='80' height='80' rx='10' fill='none' stroke='currentColor' stroke-width='2'/><line x1='10' y1='50' x2='90' y2='50' stroke='currentColor' stroke-width='1' opacity='0.3'/><line x1='50' y1='10' x2='50' y2='90' stroke='currentColor' stroke-width='1' opacity='0.3'/><polygon points='50,20 80,80 20,80' fill='currentColor' opacity='0.4'/></svg>",
            foreground: "primary", tooltip: "Triangle in box"
          end

          // Logo-style SVG
          svg width: 100, height: 100,
            source: "<svg viewBox='0 0 120 120' xmlns='http://www.w3.org/2000/svg'><g transform='translate(60,60)'><rect x='-40' y='-40' width='80' height='80' rx='8' fill='currentColor' opacity='0.15' transform='rotate(45)'/><circle cx='0' cy='0' r='25' fill='currentColor'/><circle cx='0' cy='0' r='12' fill='white'/></g></svg>",
            foreground: "primary", tooltip: "Logo with rotated rect"
          end
        end
      end

      spacer
      end

      statusbar
        label text: StatusText
        end
        spacer
        end
        label text: "SVG paths render via IMimerCanvas abstraction"
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Icon + SVG Demo",
  width: 600,
  height: 550
)
App.Mount("SvgDemo")
