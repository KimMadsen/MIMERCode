// layer_test.mc - Test layer container (children stacked on same space)
// Copyright 2026 Components4Developers - Kim Bo Madsen

view LayerDemo
  state
    ShowOverlay: Boolean := true,
    Message: String := "Layer container test"
  end

  render
    vbox flex: 1, padding: 16, gap: 12
      label text: "Layer Container Demo", font_size: 20, foreground: "primary" end

      hbox gap: 8
        button text: if ShowOverlay then "Hide Overlay" else "Show Overlay" end,
          on_click: func() ShowOverlay := not ShowOverlay end
        end
      end

      // The layer container: both children occupy the same space
      layer flex: 1, border_width: 1, border_color: "border", border_radius: 8

        // Bottom layer: content
        vbox padding: 16, gap: 8
          label text: "This is the bottom layer", font_size: 16, foreground: "text" end
          label text: "It has regular content below the overlay", foreground: "text_muted" end
          hbox gap: 8
            button text: "Button A", padding: "6 16" end
            button text: "Button B", padding: "6 16" end
            button text: "Button C", padding: "6 16" end
          end
          label text: "More content here...", foreground: "text_muted" end
          label text: "And more...", foreground: "text_muted" end
        end

        // Top layer: semi-transparent overlay (only when shown)
        if ShowOverlay then
          vbox flex: 1, background: "#00000088",
            justify: "center", align: "center", gap: 8
            label text: "OVERLAY", font_size: 24,
              foreground: "#FFFFFF", font_weight: "bold" end
            label text: Message, foreground: "#CCCCCC" end
            button text: "Dismiss", padding: "8 24",
              on_click: func() ShowOverlay := false end
            end
          end
        end
      end

      statusbar
        label text: "layer = all children share the same space, painted in order" end
      end
    end
  end
end

var App := serve("gui://", title: "Layer Container Test", width: 600, height: 450)
App.Mount("LayerDemo")
