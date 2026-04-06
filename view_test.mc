// view_test.mc - Test MimerCode view definitions
// Copyright 2026 Components4Developers - Kim Bo Madsen

// =============================================
// 1. Simple view with props and state
// =============================================

view Counter
  props
    Title: default "Counter" String,
    InitialValue: default 0 Integer
  end

  state
    Count: Integer := 0
  end

  func Increment()
    Count := Count + 1
  end

  func Decrement()
    if Count > 0 then
      Count := Count - 1
    end
  end

  render
    vbox padding: 16, gap: 8
      label text: Title, style: "heading"
      label text: f"Count: {Count}"
      hbox gap: 8
        button text: "-", on_click: Decrement
        end
        button text: "+", on_click: Increment
        end
      end
    end
  end
end

// =============================================
// 2. View with for loop in render
// =============================================

view TodoList
  props
    Title: default "Todo" String
  end

  state
    Items: Array := [],
    NewItem: String := ""
  end

  func HandleAdd()
    if Length(NewItem) > 0 then
      Items := Items + [NewItem]
      NewItem := ""
    end
  end

  func HandleRemove(Index: Integer)
    Items := remove(Items, Index)
  end

  render
    vbox padding: 20, gap: 12
      label text: Title, style: "heading"

      hbox gap: 8
        textinput value: NewItem, flex: 1,
          placeholder: "What needs doing?",
          on_change: func(V) NewItem := V end,
          on_submit: HandleAdd
        end
        button text: "Add", on_click: HandleAdd
        end
      end

      vbox gap: 4
        for I, Item in Items do
          hbox gap: 8, align: "center", key: f"todo_{I}"
            label text: Item, flex: 1
            end
            button text: "x", on_click: func() HandleRemove(I) end
            end
          end
        end
      end

      label text: f"{Length(Items)} items"
      end
    end
  end
end

// =============================================
// 3. View with conditional rendering
// =============================================

view LoginForm
  state
    Username: String := "",
    Password: String := "",
    LoggedIn: Boolean := false,
    ErrorMsg: String := ""
  end

  func HandleLogin()
    if Username = "admin" and Password = "secret" then
      LoggedIn := true
      ErrorMsg := ""
    else
      ErrorMsg := "Invalid credentials"
    end
  end

  func HandleLogout()
    LoggedIn := false
    Username := ""
    Password := ""
  end

  render
    vbox padding: 24, gap: 16
      if LoggedIn then
        label text: f"Welcome, {Username}!"
        end
        button text: "Logout", on_click: HandleLogout
        end
      else
        label text: "Login", style: "heading"
        end
        vbox gap: 8
          textinput value: Username, placeholder: "Username",
            on_change: func(V) Username := V end
          end
          textinput value: Password, placeholder: "Password",
            mask: true,
            on_change: func(V) Password := V end
          end
        end
        if Length(ErrorMsg) > 0 then
          label text: ErrorMsg, style: "error"
          end
        end
        button text: "Sign In", on_click: HandleLogin
        end
      end
    end
  end
end

WriteLn("View definitions parsed successfully!")
WriteLn("  - Counter view: props + state + methods + render")
WriteLn("  - TodoList view: for loop in render")
WriteLn("  - LoginForm view: conditional rendering with if/else")
