// table_test.mc - Table with cell editing (Phase 4)
// Copyright 2026 Components4Developers - Kim Bo Madsen

// Module-level variables shared between views
var DeleteInfo := nil
var SelIdx := -1
var Items := [
  dict{"Name": "Alice",  "Age": 30, "Dept": "Engineering", "Salary": 95000,  "Active": true,  "Level": 2, "Rating": 4},
  dict{"Name": "Bob",    "Age": 25, "Dept": "Sales",       "Salary": 65000,  "Active": true,  "Level": 1, "Rating": 2},
  dict{"Name": "Carol",  "Age": 35, "Dept": "Engineering", "Salary": 110000, "Active": false, "Level": 3, "Rating": 5},
  dict{"Name": "Dave",   "Age": 28, "Dept": "Marketing",   "Salary": 72000,  "Active": true,  "Level": 1, "Rating": 3},
  dict{"Name": "Eve",    "Age": 32, "Dept": "Sales",       "Salary": 78000,  "Active": true,  "Level": 2, "Rating": 4},
  dict{"Name": "Frank",  "Age": 41, "Dept": "Engineering", "Salary": 125000, "Active": true,  "Level": 3, "Rating": 5},
  dict{"Name": "Grace",  "Age": 29, "Dept": "HR",          "Salary": 68000,  "Active": false, "Level": 1, "Rating": 1},
  dict{"Name": "Hank",   "Age": 38, "Dept": "Marketing",   "Salary": 85000,  "Active": true,  "Level": 2, "Rating": 3},
  dict{"Name": "Irene",  "Age": 27, "Dept": "Sales",       "Salary": 70000,  "Active": true,  "Level": 1, "Rating": 2},
  dict{"Name": "Jack",   "Age": 45, "Dept": "Engineering", "Salary": 140000, "Active": true,  "Level": 4, "Rating": 5},
  dict{"Name": "Karen",  "Age": 33, "Dept": "HR",          "Salary": 74000,  "Active": true,  "Level": 2, "Rating": 3},
  dict{"Name": "Leo",    "Age": 26, "Dept": "Marketing",   "Salary": 62000,  "Active": false, "Level": 1, "Rating": 1},
  dict{"Name": "Maria",  "Age": 37, "Dept": "Engineering", "Salary": 118000, "Active": true,  "Level": 3, "Rating": 4},
  dict{"Name": "Noah",   "Age": 31, "Dept": "Sales",       "Salary": 82000,  "Active": true,  "Level": 2, "Rating": 3},
  dict{"Name": "Olivia", "Age": 29, "Dept": "HR",          "Salary": 71000,  "Active": true,  "Level": 2, "Rating": 4},
  dict{"Name": "Peter",  "Age": 42, "Dept": "Engineering", "Salary": 132000, "Active": false, "Level": 4, "Rating": 5},
  dict{"Name": "Quinn",  "Age": 24, "Dept": "Marketing",   "Salary": 58000,  "Active": true,  "Level": 1, "Rating": 2},
  dict{"Name": "Rose",   "Age": 36, "Dept": "Sales",       "Salary": 88000,  "Active": true,  "Level": 3, "Rating": 4},
  dict{"Name": "Sam",    "Age": 34, "Dept": "Engineering", "Salary": 105000, "Active": true,  "Level": 2, "Rating": 3},
  dict{"Name": "Tina",   "Age": 28, "Dept": "HR",          "Salary": 66000,  "Active": true,  "Level": 1, "Rating": 2}
]

// Reusable star rating control - click a star to set the value
view RatingStars
  props
    Value: default 0 Integer,
    OnChange: optional Callback
  end

  func StarColor(I)
    if I <= Value then
      return "#FFC107"
    end
    return "#555555"
  end

  func StarName(I)
    if I <= Value then
      return "star"
    end
    return "star_outline"
  end

  func ClickStar(I)
    if OnChange <> nil then
      OnChange(I)
    end
  end

  render
    hbox gap: 1
      for I in range(1, 6) do
        icon name: StarName(I), width: 16, height: 16,
          foreground: StarColor(I),
          on_click: func() ClickStar(I) end
        end
      end
    end
  end
end

view TableDemo
  state
    EditMsg: String := ""
  end

  func DeptBg(Dept)
    if Dept = "Engineering" then
      return "primary_dim"
    end
    if Dept = "Sales" then
      return "accent_dim"
    end
    if Dept = "Marketing" then
      return "secondary_dim"
    end
    if Dept = "HR" then
      return "success_dim"
    end
    return "surface"
  end

  func DeptFg(Dept)
    if Dept = "Engineering" then
      return "primary"
    end
    if Dept = "Sales" then
      return "accent"
    end
    if Dept = "Marketing" then
      return "secondary"
    end
    if Dept = "HR" then
      return "success"
    end
    return "text"
  end

  func ActiveLabel(Val)
    if Val then
      return "Yes"
    end
    return "No"
  end

  func ActiveColor(Val)
    if Val then
      return "success"
    end
    return "text_muted"
  end

  func DeptSalaryTotal(Dept)
    local Total := 0
    for Item in Items do
      if Item["Dept"] = Dept then
        Total := Total + Item["Salary"]
      end
    end
    return Total
  end

  func HandleCellEdit(E)
    local Row := E["row"]
    local FldName := E["field"]
    local NewVal := E["new_value"]

    // Update the data array
    if FldName = "Active" then
      Items[Row]["Active"] := NewVal
    end
    if FldName = "Name" then
      Items[Row]["Name"] := NewVal
    end
    if FldName = "Age" then
      Items[Row]["Age"] := int(NewVal)
    end
    if FldName = "Salary" then
      Items[Row]["Salary"] := int(NewVal)
    end
    if FldName = "Dept" then
      Items[Row]["Dept"] := NewVal
    end
    if FldName = "Level" then
      Items[Row]["Level"] := int(NewVal)
    end
    EditMsg := f"Edited row {Row}: {FldName} = {NewVal}"
  end

  func SetRating(RowIndex, Value)
    Items[RowIndex]["Rating"] := Value
    EditMsg := f"Set rating for row {RowIndex} to {Value}"
  end

  render
    vbox flex: 1, padding: 16, gap: 8
      label text: "Employee Table - Phase 4: Cell Editing" end
      label text: "Double-click or F2 to edit. Tab past last cell to add row. Delete key removes row. Click stars to rate.",
        foreground: "text_muted"
      end
      table data: Items, editable: true, auto_sort: true,
        auto_filter: true,
        selected: SelIdx, on_select: func(I) SelIdx := I end,
        selection_mode: "extended",
        on_cell_edit: HandleCellEdit,
        allow_add: true, allow_delete: true,
        group_by: "Dept",
        group_footer_height: 56,
        on_add: func(Ctx)
          local Dept := ""
          local Pos := Length(Items)
          if Ctx <> nil then
            if Ctx["group"] <> nil then
              Dept := Ctx["group"]
            end
            if Ctx["position"] <> nil then
              Pos := Ctx["position"]
            end
          end
          if Dept = "" then
            Dept := "HR"
          end
          local NewRow := dict{"Name": "", "Age": 0, "Dept": Dept, "Salary": 0, "Active": true, "Level": 1, "Rating": 0}
          if Pos >= Length(Items) then
            Items.Add(NewRow)
          else
            Items.Insert(Pos, NewRow)
          end
          EditMsg := f"Added new row at position {Pos}"
        end,
        on_confirm_delete: func(Info)
          // Save delete info and show themed confirmation dialog
          DeleteInfo := Info
          App.Show("ConfirmDelete")
        end,
        on_delete: func(Indices)
          // Indices is array of data indices, sorted descending
          for Idx in Indices do
            Items.Remove(Idx)
          end
          if SelIdx >= Length(Items) then
            SelIdx := Length(Items) - 1
          end
          EditMsg := f"Deleted {Length(Indices)} row(s)"
        end,
        striped: true, border: "grid", flex: 1,
        row_background: func(Row, RowIndex)
          if not Row["Active"] then
            return "surface_dim"
          end
          return ""
        end,
        row_foreground: func(Row, RowIndex)
          if not Row["Active"] then
            return "text_muted"
          end
          return ""
        end

        group_header
          hbox padding: (4, 8), gap: 8, align: "center"
            label text: f"{GroupKey}",
              font_weight: "bold",
              background: DeptBg(GroupKey),
              foreground: DeptFg(GroupKey),
              padding: (2, 8), border_radius: 4
            end
            label text: f"({GroupCount} employees)", foreground: "text_muted" end
          end
        end

        group_footer
          footer_cell field: "Salary"
            label text: f"Salary total: {DeptSalaryTotal(GroupKey)}",
              foreground: "text_muted", font_weight: "bold",
              text_align: "right", padding: (4, 6)
            end
          end
        end

        // Editable text column
        column field: "Name", header: "Name", flex: 1, sortable: true,
          filterable: true,
          font_weight: "bold", editable: 1, editor: "text"
        end

        // Editable number column
        column field: "Age", header: "Age", width: 70, align: "right",
          sortable: true, editable: 1, editor: "number"
        end

        // Cell template: department badge with select editor
        column header: "Dept", width: 130, sortable: true, field: "Dept",
          filterable: true,
          editable: 1, editor: "select",
          editor_options: "Engineering,Sales,Marketing,HR"
          cell
            label text: Row["Dept"],
              background: DeptBg(Row["Dept"]),
              foreground: DeptFg(Row["Dept"]),
              padding: (2, 8), border_radius: 4
            end
          end
        end

        // Editable number column with color-coding
        column field: "Salary", header: "Salary", width: 110, align: "right",
          sortable: true, filterable: true,
          font_weight: "bold", editable: 1, editor: "number",
          header_background: "primary_dim",
          header_foreground: "primary",
          foreground: func(Row)
            if Row["Salary"] >= 120000 then
              return "success"
            end
            if Row["Salary"] < 70000 then
              return "danger"
            end
            return "text"
          end
        end

        // Star rating column - click stars to change rating
        column field: "Rating", header: "Rating", width: 110,
          align: "center", sortable: true
          cell
            RatingStars Value: Row["Rating"],
              OnChange: func(V) SetRating(RowIndex, V) end
            end
          end
        end

        // Boolean column: click to toggle (inline checkbox)
        column header: "Active", width: 80, align: "center", field: "Active",
          editable: 1, editor: "boolean"
        end

        // Lookup select column: numeric key maps to display text
        column field: "Level", header: "Level", width: 110,
          sortable: true, editable: 1, editor: "select",
          editor_options: [
            dict{"key": 1, "value": "Junior"},
            dict{"key": 2, "value": "Mid-Level"},
            dict{"key": 3, "value": "Senior"},
            dict{"key": 4, "value": "Principal"}
          ]
        end
      end
      hbox gap: 16
        label text: f"Selected row: {SelIdx}  (Ctrl+Click/Shift+Click for multi-select)", foreground: "text_muted" end
        label text: EditMsg, foreground: "primary" end
      end
    end
  end
end

// Themed confirmation dialog - shown as modal by on_confirm_delete
view ConfirmDelete
  render
    vbox flex: 1, justify: "center", align: "center"
      vbox padding: 32, gap: 20, min_width: 340,
        background: "surface", border_radius: 12, border_width: 1,
        border_color: "border"
        label text: "Confirm Delete",
          font_size: 18, font_weight: "bold"
        end
        label text: f"Are you sure you want to delete {DeleteInfo['count']} row(s)?",
          foreground: "text_muted"
        end
        label text: "This action cannot be undone.",
          foreground: "danger", font_size: 12
        end
        hbox gap: 12, justify: "end", margin_top: 8
          button text: "Cancel", padding: "8 20",
            shortcut: "escape",
            on_click: func()
              App.Dismiss()
            end
          end
          button text: "Delete", padding: "8 20",
            background: "danger", foreground: "on_danger",
            shortcut: "enter",
            on_click: func()
              App.Dismiss()
              // Perform deletion using saved indices (descending)
              for Idx in DeleteInfo["rows"] do
                Items.Remove(Idx)
              end
              if SelIdx >= Length(Items) then
                SelIdx := Length(Items) - 1
              end
            end
          end
        end
      end
    end
  end
end

var App := serve("gui://", title: "Table Phase 4 - Cell Editing", width: 900, height: 580)
App.Mount("TableDemo")
