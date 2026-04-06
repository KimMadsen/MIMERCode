// chart_test.mc - Chart component demonstration
// Copyright 2026 Components4Developers - Kim Bo Madsen

view ChartDemo
  state
    StatusText: String := "Hover over chart elements",
    ChartType: String := "bar",
    ShowStacked: Boolean := false,
    MonthlySales := [
      dict{ "Month": "Jan", "Revenue": 12000, "Cost": 8000, "Profit": 4000 },
      dict{ "Month": "Feb", "Revenue": 15000, "Cost": 9500, "Profit": 5500 },
      dict{ "Month": "Mar", "Revenue": 13500, "Cost": 8800, "Profit": 4700 },
      dict{ "Month": "Apr", "Revenue": 17200, "Cost": 10100, "Profit": 7100 },
      dict{ "Month": "May", "Revenue": 16800, "Cost": 9900, "Profit": 6900 },
      dict{ "Month": "Jun", "Revenue": 19500, "Cost": 11200, "Profit": 8300 }
    ],
    MarketData := [
      dict{ "Company": "Acme Corp", "Share": 35 },
      dict{ "Company": "Globex", "Share": 25 },
      dict{ "Company": "Initech", "Share": 20 },
      dict{ "Company": "Umbrella", "Share": 12 },
      dict{ "Company": "Other", "Share": 8 }
    ]
  end

  func HandleClick(Point)
    if Point <> nil then
      StatusText := f"Clicked: {Point.Series} at {Point.X} = {Point.Value}"
    end
  end

  func HandleHover(Point)
    if Point <> nil then
      StatusText := f"Hover: {Point.Series} at {Point.X} = {Point.Value}"
    else
      StatusText := "Hover over chart elements"
    end
  end

  render
    vbox flex: 1, padding: 16, gap: 12
      label text: "Chart Component Demo", font_size: 20,
        foreground: "primary"
      end

      hbox gap: 8
        button text: "Bar",
          on_click: func() ChartType := "bar" end
        end
        button text: "Line",
          on_click: func() ChartType := "line" end
        end
        button text: "Area",
          on_click: func() ChartType := "area" end
        end
        button text: "Scatter",
          on_click: func() ChartType := "scatter" end
        end
        button text: "Pie",
          on_click: func() ChartType := "pie" end
        end
        button text: "Donut",
          on_click: func() ChartType := "donut" end
        end

        spacer end

        label text: f"Type: {ChartType}", foreground: "text_muted" end

        checkbox label: "Stacked", checked: ShowStacked,
          on_change: func(V) ShowStacked := V end
        end
      end

      if ChartType = "pie" or ChartType = "donut" then
        chart type: ChartType, data: MarketData,
          label: "Company", value: "Share",
          title: "Market Share",
          show_percent: true,
          inner_radius: 0.55,
          center_text: "Total",
          center_value: "100%",
          on_click: HandleClick,
          on_hover: HandleHover,
          flex: 1

          legend position: "top", interactive: true end
        end
      else
        chart type: ChartType, data: MonthlySales,
          x: "Month", y: ["Revenue", "Cost", "Profit"],
          stacked: ShowStacked,
          title: "Monthly Sales Performance",
          on_click: HandleClick,
          on_hover: HandleHover,
          flex: 1

          y_axis label: "Amount ($)", format: "$,.0f", min: 0 end

          legend position: "top", interactive: true end
        end
      end

      statusbar
        label text: StatusText end
      end
    end
  end
end

local App := serve("gui://",
  title: "Chart Demo",
  width: 900,
  height: 600
)
App.Mount("ChartDemo")
