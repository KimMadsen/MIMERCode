// map_chart_demo.mc - Map Chart demonstration
// Copyright 2026 Components4Developers - Kim Bo Madsen
//
// Demonstrates: choropleth map, color scales, drill-down navigation,
// hover tooltips, region labels, legend bar, back navigation.
// Requires: world.mcmap and country maps from map_downloader.mc

view MapChartDemo
  state
    CurrentMap: String := "world",
    MapHistory := [],
    StatusText: String := "Click a country to drill down",
    ColorScale: String := "blue",
    ShowLabels: Boolean := false,
    DrillEnabled: Boolean := true,

    // Sample world data (ISO A2 codes)
    WorldData := [
      dict{ "Code": "US", "Name": "United States", "Value": 25460 },
      dict{ "Code": "CN", "Name": "China", "Value": 17960 },
      dict{ "Code": "JP", "Name": "Japan", "Value": 4230 },
      dict{ "Code": "DE", "Name": "Germany", "Value": 4070 },
      dict{ "Code": "GB", "Name": "United Kingdom", "Value": 3070 },
      dict{ "Code": "IN", "Name": "India", "Value": 3390 },
      dict{ "Code": "FR", "Name": "France", "Value": 2780 },
      dict{ "Code": "IT", "Name": "Italy", "Value": 2010 },
      dict{ "Code": "CA", "Name": "Canada", "Value": 2140 },
      dict{ "Code": "KR", "Name": "South Korea", "Value": 1670 },
      dict{ "Code": "BR", "Name": "Brazil", "Value": 1920 },
      dict{ "Code": "AU", "Name": "Australia", "Value": 1680 },
      dict{ "Code": "MX", "Name": "Mexico", "Value": 1290 },
      dict{ "Code": "ES", "Name": "Spain", "Value": 1400 },
      dict{ "Code": "SE", "Name": "Sweden", "Value": 590 },
      dict{ "Code": "NO", "Name": "Norway", "Value": 580 },
      dict{ "Code": "DK", "Name": "Denmark", "Value": 400 },
      dict{ "Code": "NZ", "Name": "New Zealand", "Value": 250 },
      dict{ "Code": "ZA", "Name": "South Africa", "Value": 400 },
      dict{ "Code": "RU", "Name": "Russia", "Value": 2240 },
      dict{ "Code": "SA", "Name": "Saudi Arabia", "Value": 1100 },
      dict{ "Code": "TR", "Name": "Turkey", "Value": 910 },
      dict{ "Code": "NL", "Name": "Netherlands", "Value": 1010 },
      dict{ "Code": "CH", "Name": "Switzerland", "Value": 810 },
      dict{ "Code": "PL", "Name": "Poland", "Value": 690 },
      dict{ "Code": "ID", "Name": "Indonesia", "Value": 1320 },
      dict{ "Code": "TH", "Name": "Thailand", "Value": 500 },
      dict{ "Code": "NG", "Name": "Nigeria", "Value": 470 },
      dict{ "Code": "EG", "Name": "Egypt", "Value": 480 },
      dict{ "Code": "AR", "Name": "Argentina", "Value": 630 }
    ],

    // US states sample data (ISO 3166-2 codes)
    USData := [
      dict{ "Code": "US-CA", "Name": "California", "Value": 3600 },
      dict{ "Code": "US-TX", "Name": "Texas", "Value": 2000 },
      dict{ "Code": "US-NY", "Name": "New York", "Value": 1900 },
      dict{ "Code": "US-FL", "Name": "Florida", "Value": 1400 },
      dict{ "Code": "US-IL", "Name": "Illinois", "Value": 950 },
      dict{ "Code": "US-PA", "Name": "Pennsylvania", "Value": 880 },
      dict{ "Code": "US-OH", "Name": "Ohio", "Value": 760 },
      dict{ "Code": "US-GA", "Name": "Georgia", "Value": 680 },
      dict{ "Code": "US-WA", "Name": "Washington", "Value": 640 },
      dict{ "Code": "US-MA", "Name": "Massachusetts", "Value": 620 },
      dict{ "Code": "US-NJ", "Name": "New Jersey", "Value": 600 },
      dict{ "Code": "US-NC", "Name": "North Carolina", "Value": 590 },
      dict{ "Code": "US-VA", "Name": "Virginia", "Value": 570 },
      dict{ "Code": "US-MI", "Name": "Michigan", "Value": 540 }
    ],

    // Germany states sample data
    DEData := [
      dict{ "Code": "DE-NW", "Name": "Nordrhein-Westfalen", "Value": 720 },
      dict{ "Code": "DE-BY", "Name": "Bayern", "Value": 650 },
      dict{ "Code": "DE-BW", "Name": "Baden-Wuerttemberg", "Value": 540 },
      dict{ "Code": "DE-NI", "Name": "Niedersachsen", "Value": 320 },
      dict{ "Code": "DE-HE", "Name": "Hessen", "Value": 310 },
      dict{ "Code": "DE-BE", "Name": "Berlin", "Value": 170 },
      dict{ "Code": "DE-SN", "Name": "Sachsen", "Value": 140 },
      dict{ "Code": "DE-HH", "Name": "Hamburg", "Value": 130 },
      dict{ "Code": "DE-SH", "Name": "Schleswig-Holstein", "Value": 110 },
      dict{ "Code": "DE-RP", "Name": "Rheinland-Pfalz", "Value": 160 }
    ],

    // Denmark regions sample data
    DKData := [
      dict{ "Code": "DK-84", "Name": "Hovedstaden", "Value": 155 },
      dict{ "Code": "DK-82", "Name": "Midtjylland", "Value": 85 },
      dict{ "Code": "DK-83", "Name": "Syddanmark", "Value": 65 },
      dict{ "Code": "DK-81", "Name": "Nordjylland", "Value": 40 },
      dict{ "Code": "DK-85", "Name": "Sjaelland", "Value": 55 }
    ]
  end

  func GetDataForMap(MapId)
    if MapId = "world" then
      return WorldData
    end
    if MapId = "us-states" then
      return USData
    end
    if MapId = "de-states" then
      return DEData
    end
    if MapId = "dk-regions" then
      return DKData
    end
    return []
  end

  func GetTitleForMap(MapId)
    if MapId = "world" then
      return "World GDP by Country (Billion USD, 2023)"
    end
    if MapId = "us-states" then
      return "US GDP by State (Billion USD)"
    end
    if MapId = "de-states" then
      return "Germany GDP by State (Billion EUR)"
    end
    if MapId = "dk-regions" then
      return "Denmark GDP by Region (Billion DKK)"
    end
    return f"Map: {MapId}"
  end

  func HandleDrill(Info)
    if Info["HasChildren"] = true then
      MapHistory := MapHistory + [CurrentMap]
      CurrentMap := Info["ChildMap"]
      StatusText := f"Viewing: {Info['Name']} - Click to explore"
    else
      StatusText := f"{Info['Name']}: No sub-regions available"
    end
  end

  func HandleHover(Info)
    if Info["Code"] <> "" then
      local Val := Info["Value"]
      if Val > 0 then
        StatusText := f"{Info['Name']}: {Val}"
      else
        StatusText := f"{Info['Name']}: No data"
      end
    else
      StatusText := "Hover over a region"
    end
  end

  func GoBack()
    if Length(MapHistory) > 0 then
      CurrentMap := MapHistory[Length(MapHistory) - 1]
      MapHistory := MapHistory[:-1]
      StatusText := "Click a country to drill down"
    end
  end

  func GoHome()
    CurrentMap := "world"
    MapHistory := []
    StatusText := "Click a country to drill down"
  end

  render
    vbox flex: 1, padding: 12, gap: 8
      // Title bar
      hbox gap: 8, align: "center"
        label text: GetTitleForMap(CurrentMap),
          font_size: 18, foreground: "primary"
        end
        spacer end
        label text: StatusText, font_size: 11, foreground: "text_muted" end
      end

      // The map chart
      chart type: "map", flex: 1,
        data: GetDataForMap(CurrentMap),
        map: CurrentMap,
        region: "Code",
        value: "Value",
        color_scale: ColorScale,
        default_color: "#2a3a4a",
        highlight_color: "primary",
        map_background: "#0f1923",
        border_color: "#3a4a5a",
        show_labels: ShowLabels,
        drilldown: DrillEnabled,
        on_drill: func(Info) HandleDrill(Info) end,
        on_hover: func(Info) HandleHover(Info) end
      end

      // Controls
      hbox gap: 8, align: "center"
        // Navigation
        if Length(MapHistory) > 0 then
          button text: "Back",
            on_click: func() GoBack() end
          end
          button text: "Home",
            on_click: func() GoHome() end
          end
        end

        // Color scale selector
        label text: "Scale:", font_size: 11, foreground: "text_muted" end
        button text: "Blue",
          on_click: func() ColorScale := "blue" end,
          background: if ColorScale = "blue" then "primary" else "surface_dim" end,
          foreground: if ColorScale = "blue" then "on_primary" else "text" end
        end
        button text: "Red",
          on_click: func() ColorScale := "red" end,
          background: if ColorScale = "red" then "primary" else "surface_dim" end,
          foreground: if ColorScale = "red" then "on_primary" else "text" end
        end
        button text: "Green",
          on_click: func() ColorScale := "green" end,
          background: if ColorScale = "green" then "primary" else "surface_dim" end,
          foreground: if ColorScale = "green" then "on_primary" else "text" end
        end
        button text: "Diverging",
          on_click: func() ColorScale := "diverging" end,
          background: if ColorScale = "diverging" then "primary" else "surface_dim" end,
          foreground: if ColorScale = "diverging" then "on_primary" else "text" end
        end

        spacer end

        // Toggle labels
        checkbox checked: ShowLabels,
          on_change: func(V) ShowLabels := V end
        end
        label text: "Labels", font_size: 11, foreground: "text_muted" end

        // Toggle drilldown
        checkbox checked: DrillEnabled,
          on_change: func(V) DrillEnabled := V end
        end
        label text: "Drill-down", font_size: 11, foreground: "text_muted" end
      end
    end
  end
end

local App := serve("gui://",
  title: "Map Chart Demo",
  width: 1000,
  height: 700
)
App.Mount("MapChartDemo")
