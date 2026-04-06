// map_downloader.mc - Download and convert Natural Earth map data
// Copyright 2026 Components4Developers - Kim Bo Madsen
//
// Usage: Run this script in MimerCodeGuiRunner.
// It downloads Natural Earth GeoJSON data from GitHub and
// converts it to .mcmap format for use with chart type: "map".
// Downloads are cached: the shared states/provinces file (10m, ~25 MB)
// is downloaded only once even when converting multiple countries.

// Map definitions: each entry describes a downloadable map
local MapDefs := [
  dict{
    "id": "world",
    "label": "World Countries",
    "desc": "All countries (110m simplified)",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_110m_admin_0_countries.geojson",
    "options": dict{ "id_field": "ISO_A2", "name_field": "NAME", "simplify": 0.01 },
    "size": "~800 KB"
  },
  dict{
    "id": "us-states",
    "label": "US States",
    "desc": "United States - state boundaries",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "US" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "ca-provinces",
    "label": "Canada Provinces",
    "desc": "Canadian provinces and territories",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "CA" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "de-states",
    "label": "Germany States",
    "desc": "German Bundeslaender",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "DE" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "dk-regions",
    "label": "Denmark Regions",
    "desc": "Danish regions",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "DK" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "gb-regions",
    "label": "United Kingdom",
    "desc": "UK regions",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "GB" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "fr-regions",
    "label": "France Regions",
    "desc": "French administrative regions",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "FR" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "es-communities",
    "label": "Spain Communities",
    "desc": "Spanish autonomous communities",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "ES" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "it-regions",
    "label": "Italy Regions",
    "desc": "Italian administrative regions",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "IT" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "cn-provinces",
    "label": "China Provinces",
    "desc": "Chinese provinces and regions",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "CN" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "in-states",
    "label": "India States",
    "desc": "Indian states and territories",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "IN" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "jp-prefectures",
    "label": "Japan Prefectures",
    "desc": "Japanese prefectures",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "JP" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "kr-provinces",
    "label": "South Korea Provinces",
    "desc": "South Korean provinces",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "KR" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "au-states",
    "label": "Australia States",
    "desc": "Australian states and territories",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "AU" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "nz-regions",
    "label": "New Zealand Regions",
    "desc": "New Zealand regions",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "NZ" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "br-states",
    "label": "Brazil States",
    "desc": "Brazilian states",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "BR" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "mx-states",
    "label": "Mexico States",
    "desc": "Mexican states",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "MX" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "za-provinces",
    "label": "South Africa Provinces",
    "desc": "South African provinces",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "ZA" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "se-counties",
    "label": "Sweden Counties",
    "desc": "Swedish counties",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "SE" },
    "size": "shared ~25 MB"
  },
  dict{
    "id": "no-counties",
    "label": "Norway Counties",
    "desc": "Norwegian counties",
    "url": "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_admin_1_states_provinces.geojson",
    "options": dict{ "id_field": "iso_3166_2", "name_field": "name", "simplify": 0.005, "filter_field": "iso_a2", "filter_value": "NO" },
    "size": "shared ~25 MB"
  }
]

view MapDownloader
  state
    StatusText: String := "Select maps to download",
    Selected := dict{},
    Installed := map_list(),
    Downloading: Boolean := false,
    DownloadLog := [],
    CurrentItem: String := "",
    DownloadCache := dict{}
  end

  func ToggleMap(MapId)
    if Selected[MapId] = true then
      Selected[MapId] := false
    else
      Selected[MapId] := true
    end
  end

  func IsInstalled(MapId)
    for M in Installed do
      if M = MapId then
        return true
      end
    end
    return false
  end

  func SelectedCount()
    local Count := 0
    for Pair in Selected do
      if Pair.Value = true then
        Count := Count + 1
      end
    end
    return Count
  end

  func SelectAllMissing()
    for MapDef in MapDefs do
      if not IsInstalled(MapDef["id"]) then
        Selected[MapDef["id"]] := true
      end
    end
  end

  func FetchGeoJSON(Url)
    // Check cache first
    if DownloadCache[Url] <> nil then
      DownloadLog := DownloadLog + ["  Using cached download"]
      return DownloadCache[Url]
    end

    // Download via HTTP channel
    local http := open(Url)
    local geojson := http.Get("")

    // Cache it
    DownloadCache[Url] := geojson
    return geojson
  end

  func DoDownload()
    Downloading := true
    DownloadLog := []
    DownloadCache := dict{}

    // Count unique URLs to show download progress
    local UniqueUrls := dict{}
    local TotalMaps := 0
    local DoneMaps := 0
    for MapDef in MapDefs do
      if Selected[MapDef["id"]] = true then
        UniqueUrls[MapDef["url"]] := true
        TotalMaps := TotalMaps + 1
      end
    end
    local UniqueCount := UniqueUrls.Count
    DownloadLog := DownloadLog + [
      f"Selected {TotalMaps} maps from {UniqueCount} unique source(s)"
    ]

    for MapDef in MapDefs do
      if Selected[MapDef["id"]] = true then
        DoneMaps := DoneMaps + 1
        CurrentItem := MapDef["label"]
        StatusText := f"[{DoneMaps}/{TotalMaps}] {MapDef['label']}..."
        DownloadLog := DownloadLog + [f"--- {MapDef['label']} ---"]

        try
          // Download (or use cache)
          if DownloadCache[MapDef["url"]] <> nil then
            DownloadLog := DownloadLog + ["  Using cached download"]
          else
            DownloadLog := DownloadLog + [f"  Downloading from source..."]
          end
          local geojson := FetchGeoJSON(MapDef["url"])

          // Convert to .mcmap
          DownloadLog := DownloadLog + ["  Converting..."]
          local result := map_import(geojson, MapDef["id"], MapDef["options"])

          if result <> nil and result["json"] <> nil then
            // Save to maps/ directory
            local ok := map_save(result["json"], MapDef["id"])
            if ok then
              local kb := int(result["size"] / 1024)
              local dbg := result["debug"]
              DownloadLog := DownloadLog + [
                f"  Saved: {result['regions']} regions, {result['points']} points, {kb} KB"
              ]
              DownloadLog := DownloadLog + ["  DEBUG written to map_debug.txt"]
              file_write("map_debug.txt", dbg)
            else
              DownloadLog := DownloadLog + ["  ERROR: Failed to save file"]
            end
          else
            DownloadLog := DownloadLog + ["  ERROR: Conversion failed"]
          end
        except on E: Exception do
          DownloadLog := DownloadLog + [f"  ERROR: {E}"]
        end

        // Deselect after processing
        Selected[MapDef["id"]] := false
      end
    end

    // Free cache to release memory
    DownloadCache := dict{}

    // Refresh installed list
    Installed := map_list()
    Downloading := false
    CurrentItem := ""
    StatusText := f"Done! Converted {DoneMaps} map(s)."
  end

  render
    vbox flex: 1, padding: 16, gap: 12
      // Header
      label text: "Map Data Manager",
        font_size: 22, foreground: "primary"
      end
      label text: "Download Natural Earth map data for chart type: \"map\". Country maps share a single download (~25 MB) which is cached automatically.",
        foreground: "text_muted", font_size: 12, wrap: true
      end

      // Map list with checkboxes
      scroll flex: 1
        vbox gap: 2
          for MapDef in MapDefs do
            hbox gap: 8, padding: 6, min_height: 36

              checkbox checked: Selected[MapDef["id"]] = true,
                on_change: func(V) ToggleMap(MapDef["id"]) end
              end

              vbox flex: 1, gap: 1
                hbox gap: 8
                  label text: MapDef["label"],
                    font_size: 13, foreground: "text"
                  end
                  if IsInstalled(MapDef["id"]) then
                    label text: "[installed]",
                      font_size: 11, foreground: "primary"
                    end
                  end
                end
                label text: MapDef["desc"],
                  font_size: 11, foreground: "text_muted"
                end
              end

              label text: MapDef["size"],
                font_size: 11, foreground: "text_muted", min_width: 100
              end
            end
          end
        end
      end

      // Download log
      if Length(DownloadLog) > 0 then
        scroll max_height: 250
          vbox gap: 1, padding: 8, background: "surface_dim"
            for LogEntry in DownloadLog do
              label text: LogEntry, font_size: 11,
                foreground: "text_muted"
              end
            end
          end
        end
      end

      // Action bar
      hbox gap: 8, align: "center"
        button text: f"Download ({SelectedCount()})",
          on_click: func() DoDownload() end,
          background: "primary",
          foreground: "on_primary"
        end
        button text: "Select Missing",
          on_click: func() SelectAllMissing() end
        end
        button text: "Select All",
          on_click: func()
            for MapDef in MapDefs do
              Selected[MapDef["id"]] := true
            end
          end
        end
        button text: "Clear",
          on_click: func()
            Selected := dict{}
          end
        end
        spacer end
        label text: StatusText, foreground: "text_muted", font_size: 12 end
      end
    end
  end
end

local App := serve("gui://",
  title: "Map Data Manager",
  width: 750,
  height: 650
)
App.Mount("MapDownloader")
