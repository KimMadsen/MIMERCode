// wargames.mc - WOPR Global Thermonuclear War Display
// Copyright 2026 Components4Developers - Kim Bo Madsen
//
// Full experience: terminal dialog -> game selection -> missile display
// Uses: layer, map chart, geo stdlib, animated SVG overlay

var Routes := [
  dict{"from": "MOSCOW",      "flat": 55.75, "flon": 37.62,
       "to": "WASHINGTON",     "tlat": 38.89, "tlon": -77.04,  "side": "red"},
  dict{"from": "MOSCOW",      "flat": 55.75, "flon": 37.62,
       "to": "NEW YORK",      "tlat": 40.71, "tlon": -74.01,  "side": "red"},
  dict{"from": "MOSCOW",      "flat": 55.75, "flon": 37.62,
       "to": "CHICAGO",       "tlat": 41.88, "tlon": -87.63,  "side": "red"},
  dict{"from": "MURMANSK",    "flat": 68.97, "flon": 33.09,
       "to": "OMAHA",         "tlat": 41.26, "tlon": -95.94,  "side": "red"},
  dict{"from": "VLADIVOSTOK", "flat": 43.12, "flon": 131.87,
       "to": "LOS ANGELES",   "tlat": 34.05, "tlon": -118.24, "side": "red"},
  dict{"from": "NOVOSIBIRSK", "flat": 55.03, "flon": 82.92,
       "to": "SEATTLE",       "tlat": 47.61, "tlon": -122.33, "side": "red"},
  dict{"from": "MOSCOW",      "flat": 55.75, "flon": 37.62,
       "to": "LONDON",        "tlat": 51.51, "tlon": -0.13,   "side": "red"},
  dict{"from": "OMAHA",       "flat": 41.26, "flon": -95.94,
       "to": "MOSCOW",        "tlat": 55.75, "tlon": 37.62,   "side": "blue"},
  dict{"from": "WASHINGTON",  "flat": 38.89, "flon": -77.04,
       "to": "MOSCOW",        "tlat": 55.75, "tlon": 37.62,   "side": "blue"},
  dict{"from": "LOS ANGELES", "flat": 34.05, "flon": -118.24,
       "to": "VLADIVOSTOK",   "tlat": 43.12, "tlon": 131.87,  "side": "blue"},
  dict{"from": "OMAHA",       "flat": 41.26, "flon": -95.94,
       "to": "BEIJING",       "tlat": 39.90, "tlon": 116.40,  "side": "blue"},
  dict{"from": "LONDON",      "flat": 51.51, "flon": -0.13,
       "to": "MOSCOW",        "tlat": 55.75, "tlon": 37.62,   "side": "blue"}
]

var MapInfo := map_info("world")
var MapBounds := MapInfo["bounds"]

func BuildMissileSvg()
  local W := 900
  local H := 500

  local Cities := dict{}
  for R in Routes do
    local FKey := R["from"]
    if not haskey(Cities, FKey) then
      Cities[FKey] := dict{"lat": R["flat"], "lon": R["flon"], "side": R["side"]}
    end
    local TKey := R["to"]
    if not haskey(Cities, TKey) then
      Cities[TKey] := dict{"lat": R["tlat"], "lon": R["tlon"], "side": R["side"]}
    end
  end

  local S := f"<svg viewBox='0 0 {W} {H}' xmlns='http://www.w3.org/2000/svg'>"

  for LonDeg in arange(-150, 180, 30) do
    local Gx := geo_mercator(0, LonDeg, W, H, MapBounds)
    local GxR := Round(Gx["x"])
    S := S + f"<line x1='{GxR}' y1='0' x2='{GxR}' y2='{H}' stroke='#003300' stroke-width='0.5'/>"
  end
  for LatDeg in arange(-60, 80, 20) do
    local Gy := geo_mercator(LatDeg, 0, W, H, MapBounds)
    local GyR := Round(Gy["y"])
    S := S + f"<line x1='0' y1='{GyR}' x2='{W}' y2='{GyR}' stroke='#003300' stroke-width='0.5'/>"
  end

  for I, R in Routes do
    local Arc := geo_great_circle(R["flat"], R["flon"], R["tlat"], R["tlon"], 40)
    local PathD := ""
    local PathLen := 0.0
    local PrevX := 0
    local PrevY := 0
    local PrevLon := R["flon"]
    for J, Pt in Arc do
      local Px := geo_mercator(Pt["lat"], Pt["lon"], W, H, MapBounds)
      local PxR := Round(Px["x"])
      local PyR := Round(Px["y"])
      if J = 0 then
        PathD := PathD + f"M{PxR} {PyR}"
      else
        if Abs(Pt["lon"] - PrevLon) > 180 then
          PathD := PathD + f" M{PxR} {PyR}"
        else
          PathD := PathD + f" L{PxR} {PyR}"
          PathLen := PathLen + hypot(PxR - PrevX, PyR - PrevY)
        end
      end
      PrevX := PxR
      PrevY := PyR
      PrevLon := Pt["lon"]
    end

    local ArcColor := "#FF3333"
    local DotColor := "#FF6666"
    if R["side"] = "blue" then
      ArcColor := "#3388FF"
      DotColor := "#66BBFF"
    end

    local Dur := 3 + (I mod 3)
    local Delay := I * 0.7
    local DashLen := Round(PathLen)
    if DashLen < 10 then
      DashLen := 10
    end

    local PathId := f"arc{I}"
    S := S + f"<path id='{PathId}' d='{PathD}' fill='none' "
    S := S + f"stroke='{ArcColor}' stroke-width='1' opacity='0' "
    S := S + f"stroke-dasharray='{DashLen}' stroke-dashoffset='{DashLen}'>"
    S := S + f"<animate attributeName='stroke-dashoffset' "
    S := S + f"values='{DashLen};0;0;0' dur='{Dur}s' begin='{Delay}s' repeatCount='indefinite'/>"
    S := S + f"<animate attributeName='opacity' values='0;0.8;0.8;0' "
    S := S + f"dur='{Dur}s' begin='{Delay}s' repeatCount='indefinite'/>"
    S := S + "</path>"

    S := S + f"<circle r='3' fill='{DotColor}' opacity='0'>"
    S := S + f"<animateMotion dur='{Dur}s' begin='{Delay}s' repeatCount='indefinite'>"
    S := S + f"<mpath href='#{PathId}'/>"
    S := S + "</animateMotion>"
    S := S + f"<animate attributeName='opacity' values='0;1;1;0' "
    S := S + f"dur='{Dur}s' begin='{Delay}s' repeatCount='indefinite'/>"
    S := S + f"<animate attributeName='r' values='2;3;4;3' "
    S := S + f"dur='{Dur}s' begin='{Delay}s' repeatCount='indefinite'/>"
    S := S + "</circle>"
  end

  for CityName in Cities.Keys() do
    local City := Cities[CityName]
    local Cp := geo_mercator(City["lat"], City["lon"], W, H, MapBounds)
    local CpX := Round(Cp["x"])
    local CpY := Round(Cp["y"])
    local MarkerColor := "#FF4444"
    if City["side"] = "blue" then
      MarkerColor := "#4488FF"
    end
    S := S + f"<circle cx='{CpX}' cy='{CpY}' r='4' "
    S := S + f"fill='none' stroke='{MarkerColor}' stroke-width='1' opacity='0.6'>"
    S := S + "<animate attributeName='r' values='4;12;4' dur='2s' repeatCount='indefinite'/>"
    S := S + "<animate attributeName='opacity' values='0.8;0;0.8' dur='2s' repeatCount='indefinite'/>"
    S := S + "</circle>"
    S := S + f"<circle cx='{CpX}' cy='{CpY}' r='2.5' fill='{MarkerColor}' opacity='0.9'/>"
    S := S + f"<text x='{CpX + 8}' y='{CpY - 6}' "
    S := S + f"fill='{MarkerColor}' font-family='monospace' font-size='7' opacity='0.7'>"
    S := S + CityName + "</text>"
  end

  for I, R in Routes do
    local Tp := geo_mercator(R["tlat"], R["tlon"], W, H, MapBounds)
    local TpX := Round(Tp["x"])
    local TpY := Round(Tp["y"])
    local Dur := 3 + (I mod 3)
    local Delay := I * 0.7 + Dur * 0.75
    S := S + f"<circle cx='{TpX}' cy='{TpY}' r='0' fill='#FFFFFF' opacity='0'>"
    S := S + f"<animate attributeName='r' values='0;18;28' dur='1s' begin='{Delay}s' repeatCount='indefinite'/>"
    S := S + f"<animate attributeName='opacity' values='0.7;0.15;0' dur='1s' begin='{Delay}s' repeatCount='indefinite'/>"
    S := S + "</circle>"
  end

  S := S + "<text x='15' y='22' fill='#FF3333' font-family='monospace' font-size='14' font-weight='bold'>DEFCON 1</text>"
  S := S + "<text x='15' y='38' fill='#00CC00' font-family='monospace' font-size='10'>WOPR STRATEGIC DEFENSE NETWORK</text>"
  S := S + "<text x='15' y='52' fill='#008800' font-family='monospace' font-size='9'>GLOBAL THERMONUCLEAR WAR</text>"
  S := S + f"<text x='{W - 95}' y='22' fill='#FF0000' font-family='monospace' font-size='16' font-weight='bold'>"
  S := S + "ALERT<animate attributeName='opacity' values='1;0.15;1' dur='1s' repeatCount='indefinite'/>"
  S := S + "</text>"
  S := S + f"<text x='15' y='{H - 10}' fill='#00AA00' font-family='monospace' font-size='9' opacity='0.6'>"
  S := S + f"TRACKS: {Length(Routes)} ACTIVE TRAJECTORIES</text>"
  S := S + f"<text x='{W - 250}' y='{H - 10}' fill='#00AA00' font-family='monospace' font-size='9' opacity='0.6'>"
  S := S + "NORAD / CHEYENNE MOUNTAIN COMPLEX</text>"
  S := S + "</svg>"
  return S
end

var MissileSvg := BuildMissileSvg()

// ---- Terminal dialog lines per stage ----
var TermLines := [
  // Stage 0: initial connection
  [
    dict{"text": "WOPR DEFENSE MAINFRAME v4.17.3",           "color": "#00CC00"},
    dict{"text": "NORAD STRATEGIC COMPUTING CENTER",         "color": "#008800"},
    dict{"text": "========================================", "color": "#004400"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "ESTABLISHING SECURE CONNECTION...",        "color": "#00AA00"},
    dict{"text": "ENCRYPTION: AES-256-MIL ACTIVE",           "color": "#006600"},
    dict{"text": "CONNECTION ESTABLISHED.",                  "color": "#00CC00"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "GREETINGS.",                               "color": "#00FF00"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "WOULD YOU LIKE TO PLAY A GAME?",           "color": "#00FF00"}
  ],
  // Stage 1: game list
  [
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "> YES",                                    "color": "#FFFFFF"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "AVAILABLE STRATEGIC GAMES:",               "color": "#00CC00"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "  1. CHESS",                               "color": "#008800"},
    dict{"text": "  2. CHECKERS",                            "color": "#008800"},
    dict{"text": "  3. BACKGAMMON",                          "color": "#008800"},
    dict{"text": "  4. POKER",                               "color": "#008800"},
    dict{"text": "  5. TACTICAL FIGHTER ENGAGEMENT",         "color": "#008800"},
    dict{"text": "  6. URBAN GUERRILLA OPERATIONS",          "color": "#008800"},
    dict{"text": "  7. DESERT THEATER COMBAT",               "color": "#008800"},
    dict{"text": "  8. THEATER-WIDE CHEMICAL WARFARE",       "color": "#008800"},
    dict{"text": "  9. INTERCONTINENTAL BALLISTIC STRIKE",   "color": "#00AA00"},
    dict{"text": " 10. GLOBAL THERMONUCLEAR WAR",            "color": "#FF3333"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "WHICH GAME DO YOU WANT TO PLAY?",          "color": "#00FF00"}
  ],
  // Stage 2: confirmation
  [
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "> 10. GLOBAL THERMONUCLEAR WAR",           "color": "#FFFFFF"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "** WARNING: CLASS-1 STRATEGIC SCENARIO **", "color": "#FF3333"},
    dict{"text": "THIS SIMULATION MODELS FULL NUCLEAR EXCHANGE", "color": "#FF6600"},
    dict{"text": "BETWEEN NATO AND WARSAW PACT FORCES.",     "color": "#FF6600"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "ESTIMATED CASUALTIES: 680,000,000",        "color": "#FF3333"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "ARE YOU SURE? (Y/N)",                      "color": "#00FF00"}
  ],
  // Stage 3: launch sequence
  [
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "> Y",                                      "color": "#FFFFFF"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "INITIALIZING SIMULATION...",               "color": "#FFCC00"},
    dict{"text": "LOADING STRATEGIC TARGET DATABASE...",     "color": "#00AA00"},
    dict{"text": "ACTIVATING DEFENSE SATELLITE NETWORK...",  "color": "#00AA00"},
    dict{"text": "COMPUTING OPTIMAL STRIKE PATTERNS...",     "color": "#00AA00"},
    dict{"text": "PRIMARY TARGETS LOCKED.",                  "color": "#FF3333"},
    dict{"text": "SECONDARY TARGETS LOCKED.",                "color": "#FF3333"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "LAUNCH SEQUENCE INITIATED.",               "color": "#FF0000"},
    dict{"text": "",                                         "color": "#000000"},
    dict{"text": "SWITCHING TO STRATEGIC DISPLAY...",        "color": "#FFCC00"}
  ]
]

// ---- Terminal View ----
view TerminalView
  state
    Stage: Integer := 0
  end

  func Advance()
    Stage := Stage + 1
    if Stage > 3 then
      App.Replace("WarGamesDisplay")
    end
  end

  func ButtonLabel()
    if Stage = 0 then
      return "> YES"
    end
    if Stage = 1 then
      return "> 10. GLOBAL THERMONUCLEAR WAR"
    end
    if Stage = 2 then
      return "> CONFIRM (Y)"
    end
    if Stage = 3 then
      return "[ ENTER STRATEGIC DISPLAY ]"
    end
    return "> CONTINUE"
  end

  render
    vbox flex: 1, background: "#000000", padding: 24, gap: 0
      // Scrollable terminal output
      scroll flex: 1, auto_scroll: true
        vbox gap: 2, padding: (0, 8)
          // Render all lines up to current stage
          for StgIdx in range(0, Stage + 1) do
            if StgIdx < Length(TermLines) then
              for Line in TermLines[StgIdx] do
                if Line["text"] = "" then
                  spacer height: 8 end
                else
                  label text: Line["text"],
                    foreground: Line["color"],
                    font_size: 13
                  end
                end
              end
            end
          end

          // Blinking cursor
          label text: "_", foreground: "#00FF00", font_size: 13 end
        end
      end

      // Input area
      hbox padding: (12, 0), gap: 12, align: "center"
        label text: "WOPR>", foreground: "#006600", font_size: 12 end
        button text: ButtonLabel(),
          padding: (6, 20),
          background: "#002200",
          foreground: "#00FF00",
          border_width: 1,
          border_color: "#004400",
          on_click: func() Advance() end
        end
        spacer end
        label text: f"STAGE {Stage + 1}/4", foreground: "#004400", font_size: 10 end
      end
    end
  end
end

// ---- War Display View ----
view WarGamesDisplay
  render
    vbox flex: 1, background: "#000000"
      hbox padding: (4, 12), background: "#001100", gap: 12, align: "center"
        icon name: "warning", foreground: "#FF3333", width: 16, height: 16 end
        label text: "WOPR - War Operation Plan Response",
          foreground: "#00DD00", font_size: 12, font_weight: "bold" end
        spacer end
        label text: "SIMULATION ACTIVE", foreground: "#FF4444", font_size: 10 end
      end

      layer flex: 1
        chart type: "map", flex: 1,
          map: "world",
          data: [dict{"code": "XX", "value": 0}],
          chart_padding: 0,
          background: "#000a00",
          map_background: "#000a00",
          default_color: "#003d00",
          border_color: "#006600",
          highlight_color: "#005500",
          show_tooltip: false
        end
        svg flex: 1, source: MissileSvg end
      end

      hbox padding: (4, 12), background: "#001100", gap: 20
        label text: "A STRANGE GAME.", foreground: "#00AA00", font_size: 10 end
        label text: "THE ONLY WINNING MOVE IS NOT TO PLAY.",
          foreground: "#00CC00", font_size: 10, font_weight: "bold" end
        spacer end
        button text: "PLAY AGAIN",
          padding: (4, 16),
          background: "#002200",
          foreground: "#006600",
          border_width: 1,
          border_color: "#003300",
          on_click: func() App.Replace("TerminalView") end
        end
      end
    end
  end
end

var App := serve("gui://",
  title: "WOPR - Global Thermonuclear War",
  width: 950, height: 580
)
App.Mount("TerminalView")
