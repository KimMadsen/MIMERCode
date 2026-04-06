// controls_test.mc - Slider, Progress, Tooltip, Image demonstration
// Copyright 2026 Components4Developers - Kim Bo Madsen

view ControlsDemo
  state
    Volume: Float := 50.0,
    Brightness: Float := 75.0,
    Progress1: Float := 35.0,
    Progress2: Float := 68.0,
    StatusText: String := "Adjust the sliders"
  end

  func HandleVolume(V)
    Volume := V
    StatusText := f"Volume: {round(V)}%"
  end

  func HandleBrightness(V)
    Brightness := V
    StatusText := f"Brightness: {round(V)}%"
  end

  func IncProgress()
    Progress1 := Progress1 + 10
    if Progress1 > 100 then
      Progress1 := 0
    end
    StatusText := f"Progress: {round(Progress1)}%"
  end

  render
    vbox flex: 1, padding: 20, gap: 16
      label text: "Controls Demo", font_size: 20, foreground: "primary"
      end

      // Sliders
      vbox gap: 10
        label text: "Sliders", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 12, align: "center"
          label text: "Volume:", width: 80
          end
          slider flex: 1, value: Volume, min: 0, max: 100, step: 1,
            key: "volume",
            on_change: HandleVolume, tooltip: "Drag to adjust volume"
          end
          label text: f"{round(Volume)}%", width: 45
          end
        end

        hbox gap: 12, align: "center"
          label text: "Brightness:", width: 80
          end
          slider flex: 1, value: Brightness, min: 0, max: 100, step: 5,
            key: "brightness",
            on_change: HandleBrightness, tooltip: "Drag to adjust brightness (step: 5)"
          end
          label text: f"{round(Brightness)}%", width: 45
          end
        end
      end

      separator
      end

      // Progress bars
      vbox gap: 10
        label text: "Progress Bars", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 12, align: "center"
          label text: "Upload:", width: 80
          end
          progress flex: 1, value: Progress1, max: 100
          end
          label text: f"{round(Progress1)}%", width: 45
          end
        end

        hbox gap: 12, align: "center"
          label text: "Sync:", width: 80
          end
          progress flex: 1, value: Progress2, max: 100
          end
          label text: f"{round(Progress2)}%", width: 45
          end
        end

        hbox gap: 12, align: "center"
          label text: "Loading:", width: 80
          end
          progress flex: 1, indeterminate: true
          end
        end

        button text: "Advance Upload", on_click: IncProgress,
          tooltip: "Click to increment upload progress by 10%"
        end
      end

      separator
      end

      // Tooltips on various elements
      vbox gap: 10
        label text: "Tooltips (hover over elements)", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 8
          button text: "Save", tooltip: "Save the current file (Ctrl+S)"
          end
          button text: "Run", tooltip: "Execute the script (Ctrl+R)"
          end
          button text: "Debug", tooltip: "Run with debugger attached"
          end
          label text: "Hover over buttons!", foreground: "text_muted",
            tooltip: "Even labels can have tooltips"
          end
        end
      end

      separator
      end

      // Image controls
      vbox gap: 10
        label text: "Images", font_size: 14, foreground: "text_muted"
        end

        hbox gap: 12
          vbox gap: 4, align: "center"
            image src: "test_photo.png", width: 120, height: 90,
              tooltip: "Set src to a real image path"
            end
            label text: "Photo", font_size: 11, foreground: "text_muted"
            end
          end

          vbox gap: 4, align: "center"
            image src: "icon.png", width: 64, height: 64,
              tooltip: "64x64 icon"
            end
            label text: "Icon", font_size: 11, foreground: "text_muted"
            end
          end

          vbox gap: 4, align: "center"
            image width: 100, height: 70,
              tooltip: "No src = placeholder border"
            end
            label text: "No image", font_size: 11, foreground: "text_muted"
            end
          end
        end
      end

      spacer
      end

      statusbar
        label text: StatusText
        end
      end
    end
  end
end

local App := serve("gui://",
  title: "Slider + Progress + Tooltip Demo",
  width: 550,
  height: 700
)
App.Mount("ControlsDemo")
