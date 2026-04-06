// tabs_test.mc - Test MimerCode tabs with all placements
// Copyright 2026 Components4Developers - Kim Bo Madsen

view DynTabs
  props
    Placement: default "top" String,
    UseWrap: default false Boolean,
    UseVertText: default true Boolean,
    UseClosable: default true Boolean
  end
  state
    ActiveTab: Integer := 0,
    Tabs: Array := ["alpha.mc", "bravo.mc", "charlie.mc", "delta.mc",
                    "echo.mc", "foxtrot.mc", "golf.mc", "hotel.mc"],
    Log: String := "Ready",
    RowCount: Integer := 0
  end

  func HandleTabChange(Index: Integer)
    ActiveTab := Index
    Log := f"Tab {Index}: {Tabs[Index]}"
  end

  func HandleTabClose(Index: Integer)
    local Name := Tabs[Index]
    Tabs.Remove(Index)
    if ActiveTab >= Length(Tabs) then
      ActiveTab := Length(Tabs) - 1
    end
    if ActiveTab < 0 then
      ActiveTab := 0
    end
    Log := f"Closed: {Name}"
  end

  func AddTab()
    local Name := f"new_{Length(Tabs)}.mc"
    Tabs := Tabs + [Name]
    ActiveTab := Length(Tabs) - 1
    Log := f"Added: {Name}"
  end

  func IncRows()
    RowCount := RowCount + 1
  end

  func DecRows()
    RowCount := RowCount - 1
    if RowCount < 0 then
      RowCount := 0
    end
  end

  render
    vbox flex: 1
      hbox padding: (4, 8), gap: 4
        button text: "+ Add Tab", on_click: AddTab
        end
        if UseWrap then
          button text: "Rows-", on_click: DecRows
          end
          label text: f"Rows:{RowCount}", padding: (0, 4)
          end
          button text: "Rows+", on_click: IncRows
          end
        end
        spacer
        end
        label text: f"Rows: {RowCount} (0=auto)", foreground: "text_muted"
        end
      end
      tabs flex: 1, active: ActiveTab,
        placement: Placement,
        wrap: UseWrap,
        rows: RowCount,
        vertical_text: UseVertText,
        closable: UseClosable,
        on_change: HandleTabChange,
        on_close: HandleTabClose
        for I, Name in Tabs do
          tab text: Name
            vbox padding: 16, gap: 8
              label text: f"Content of {Name}"
              end
              label text: f"Tab index: {I}"
              end
            end
          end
        end
      end
    end
  end
end

view Main
  state
    Mode: String := "top"
  end

  render
    vbox flex: 1
      hbox padding: 8, gap: 4
        button text: "Top", on_click: func() Mode := "top" end
        end
        button text: "Bottom", on_click: func() Mode := "bottom" end
        end
        button text: "Left(V)", on_click: func() Mode := "left_v" end
        end
        button text: "Left(H)", on_click: func() Mode := "left_h" end
        end
        button text: "Right(V)", on_click: func() Mode := "right_v" end
        end
        button text: "Right(H)", on_click: func() Mode := "right_h" end
        end
        button text: "Wrap", on_click: func() Mode := "wrap" end
        end
      end
      label text: f"Mode: {Mode}", padding: (2, 8), foreground: "text_muted"
      end
      separator
      end
      if Mode = "top" then
        DynTabs flex: 1, key: "top", Placement: "top", UseWrap: false
        end
      else
        if Mode = "bottom" then
          DynTabs flex: 1, key: "bottom", Placement: "bottom"
          end
        else
          if Mode = "left_v" then
            DynTabs flex: 1, key: "left_v", Placement: "left",
              UseVertText: true
            end
          else
            if Mode = "left_h" then
              DynTabs flex: 1, key: "left_h", Placement: "left",
                UseVertText: false
              end
            else
              if Mode = "right_v" then
                DynTabs flex: 1, key: "right_v", Placement: "right",
                  UseVertText: true
                end
              else
                if Mode = "right_h" then
                  DynTabs flex: 1, key: "right_h", Placement: "right",
                    UseVertText: false
                  end
                else
                  DynTabs flex: 1, key: "wrap", Placement: "top",
                    UseWrap: true
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

local App := serve("gui://")
App.Title("Tabs Test")
App.Mount("Main")
