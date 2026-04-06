// svg_anim_test.mc - Animated SVG demonstrations (SMIL)
// Copyright 2026 Components4Developers - Kim Bo Madsen

view SvgAnimDemo
  state
    ShowCheck: Boolean := false
  end

  func ToggleCheck()
    ShowCheck := not ShowCheck
  end

  render
    vbox flex: 1, padding: 20, gap: 16
      label text: "Animated SVGs (SMIL)", font_size: 20, foreground: "primary"
      end

      // Spinning loaders
      vbox gap: 10
        label text: "Spinners", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 24, align: "center"
          // Arc spinner
          svg width: 48, height: 48, foreground: "primary",
            source: "<svg viewBox='0 0 50 50' xmlns='http://www.w3.org/2000/svg'><g><animateTransform attributeName='transform' type='rotate' from='0 25 25' to='360 25 25' dur='1s' repeatCount='indefinite'/><path d='M25 5a20 20 0 0 1 20 20' fill='none' stroke='currentColor' stroke-width='4' stroke-linecap='round'/></g></svg>",
            tooltip: "Arc spinner (1s rotation)"
          end

          // Double ring spinner
          svg width: 48, height: 48, foreground: "primary",
            source: "<svg viewBox='0 0 50 50' xmlns='http://www.w3.org/2000/svg'><circle cx='25' cy='25' r='20' fill='none' stroke='currentColor' stroke-width='2' opacity='0.2'/><g><animateTransform attributeName='transform' type='rotate' from='0 25 25' to='360 25 25' dur='0.8s' repeatCount='indefinite'/><path d='M25 5a20 20 0 0 1 15 30' fill='none' stroke='currentColor' stroke-width='3' stroke-linecap='round'/></g></svg>",
            tooltip: "Double ring spinner"
          end

          // Pulsing dot
          svg width: 48, height: 48, foreground: "primary",
            source: "<svg viewBox='0 0 50 50' xmlns='http://www.w3.org/2000/svg'><circle cx='25' cy='25' r='8' fill='currentColor'><animate attributeName='r' values='8;14;8' dur='1.5s' repeatCount='indefinite'/><animate attributeName='opacity' values='1;0.3;1' dur='1.5s' repeatCount='indefinite'/></circle></svg>",
            tooltip: "Pulsing dot"
          end

          // Three dots loader
          svg width: 64, height: 48, foreground: "text",
            source: "<svg viewBox='0 0 80 50' xmlns='http://www.w3.org/2000/svg'><circle cx='20' cy='25' r='6' fill='currentColor'><animate attributeName='opacity' values='1;0.3;1' dur='1.2s' begin='0s' repeatCount='indefinite'/></circle><circle cx='40' cy='25' r='6' fill='currentColor'><animate attributeName='opacity' values='1;0.3;1' dur='1.2s' begin='0.2s' repeatCount='indefinite'/></circle><circle cx='60' cy='25' r='6' fill='currentColor'><animate attributeName='opacity' values='1;0.3;1' dur='1.2s' begin='0.4s' repeatCount='indefinite'/></circle></svg>",
            tooltip: "Three dots (staggered begin)"
          end
        end
      end

      separator
      end

      // Animated shapes
      vbox gap: 10
        label text: "Shape Animations", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 24, align: "center"
          // Breathing square
          svg width: 64, height: 64, foreground: "primary",
            source: "<svg viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'><rect x='20' y='20' width='60' height='60' rx='8' fill='currentColor' opacity='0.6'><animate attributeName='rx' values='8;20;8' dur='2s' repeatCount='indefinite'/><animate attributeName='opacity' values='0.6;0.9;0.6' dur='2s' repeatCount='indefinite'/></rect></svg>",
            tooltip: "Breathing rounded corners"
          end

          // Orbiting dot
          svg width: 64, height: 64, foreground: "primary",
            source: "<svg viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'><circle cx='50' cy='50' r='30' fill='none' stroke='currentColor' stroke-width='1' opacity='0.3'/><g><animateTransform attributeName='transform' type='rotate' from='0 50 50' to='360 50 50' dur='2s' repeatCount='indefinite'/><circle cx='50' cy='20' r='6' fill='currentColor'/></g></svg>",
            tooltip: "Orbiting dot"
          end

          // Scaling star
          svg width: 64, height: 64, foreground: "#FFC107",
            source: "<svg viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><g><animateTransform attributeName='transform' type='scale' values='0.8;1.1;0.8' dur='1.5s' repeatCount='indefinite'/><path d='M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z' fill='currentColor'/></g></svg>",
            tooltip: "Scaling star"
          end
        end
      end

      separator
      end

      // Stroke reveal
      vbox gap: 10
        label text: "Stroke Reveal", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 24, align: "center"
          // Checkmark stroke reveal
          svg width: 64, height: 64, foreground: "primary",
            source: "<svg viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><circle cx='12' cy='12' r='10' fill='none' stroke='currentColor' stroke-width='1.5' opacity='0.3'/><path d='M7 12.5l3 3 7-7' fill='none' stroke='currentColor' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round' stroke-dasharray='20' stroke-dashoffset='20'><animate attributeName='stroke-dashoffset' from='20' to='0' dur='0.6s' fill='freeze'/></path></svg>",
            tooltip: "Checkmark draw-in (stroke-dashoffset)"
          end

          // Circle progress
          svg width: 64, height: 64, foreground: "primary",
            source: "<svg viewBox='0 0 50 50' xmlns='http://www.w3.org/2000/svg'><circle cx='25' cy='25' r='20' fill='none' stroke='currentColor' stroke-width='3' opacity='0.15'/><circle cx='25' cy='25' r='20' fill='none' stroke='currentColor' stroke-width='3' stroke-dasharray='126' stroke-dashoffset='126' stroke-linecap='round'><animate attributeName='stroke-dashoffset' from='126' to='0' dur='2s' fill='freeze'/></circle></svg>",
            tooltip: "Circle progress reveal"
          end

          // Line draw
          svg width: 100, height: 48, foreground: "text",
            source: "<svg viewBox='0 0 100 40' xmlns='http://www.w3.org/2000/svg'><path d='M5 35 L25 5 L45 25 L65 10 L95 30' fill='none' stroke='currentColor' stroke-width='2' stroke-dasharray='150' stroke-dashoffset='150'><animate attributeName='stroke-dashoffset' from='150' to='0' dur='1.5s' fill='freeze'/></path></svg>",
            tooltip: "Chart line draw-in"
          end
        end
      end

      spacer
      end

      statusbar
        label text: "SMIL animations render at 60fps via IMimerCanvas abstraction"
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Animated SVG Demo",
  width: 650,
  height: 600
)
App.Mount("SvgAnimDemo")
