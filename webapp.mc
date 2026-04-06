// webapp.mc - MimerCode Web Application with Login
// A web application demonstrating contracts, channels, auth, and HTTP serving
// Copyright 2026 Components4Developers - Kim Bo Madsen

// =============================================
// Data Contracts
// =============================================

contract LoginRequest
  Username: required String minlen(1) maxlen(100),
  Password: required String minlen(1) sensitive
end

contract UserProfile requires role("user")
  UserId: optional Integer
end

contract AdminAction requires role("admin")
  Action: optional String
end

contract UserSearch
  Name:   optional String like,
  Page:   default 1 Integer range(1, 9999)
end

contract NewUser requires role("admin")
  Username: required String minlen(3) maxlen(50),
  Password: required String minlen(6) sensitive,
  Role:     default "user" String oneof("user", "admin", "editor")
end

// =============================================
// Setup
// =============================================

WriteLn("Starting MimerCode Web Application...")

local Auth := open("auth://users.json")

// Create default users
Auth("create", dict{
  "Username": "admin",
  "Password": "admin123",
  "Roles": ["admin", "user"]
})
Auth("create", dict{
  "Username": "kim",
  "Password": "secret123",
  "Roles": ["user"]
})
Auth("create", dict{
  "Username": "anna",
  "Password": "editor456",
  "Roles": ["user", "editor"]
})

local Web := serve("http://0.0.0.0:8080", Auth)

// =============================================
// Shared HTML fragments
// =============================================

local CSS := """
    <style>
      body { font-family: Arial, sans-serif; max-width: 800px; margin: 40px auto;
             padding: 0 20px; background: #f5f5f5; }
      h1 { color: #2c3e50; }
      h2 { color: #34495e; }
      .card { background: white; padding: 20px; border-radius: 8px;
              box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin: 20px 0; }
      .btn { display: inline-block; padding: 10px 20px; background: #3498db;
             color: white; text-decoration: none; border-radius: 4px;
             border: none; cursor: pointer; font-size: 14px; margin: 2px; }
      .btn:hover { background: #2980b9; }
      .btn-danger { background: #e74c3c; }
      .btn-success { background: #27ae60; }
      input[type=text], input[type=password] {
        padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;
        font-size: 14px; width: 250px; margin: 5px 0; }
      .form-group { margin: 12px 0; }
      .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
      .alert { padding: 12px 20px; border-radius: 4px; margin: 10px 0; }
      .alert-error { background: #fde8e8; color: #c0392b; border: 1px solid #f5c6cb; }
      .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
      .alert-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
      .nav { background: #2c3e50; padding: 12px 20px; border-radius: 4px; margin-bottom: 20px; }
      .nav a { color: white; text-decoration: none; margin-right: 15px; font-size: 14px; }
      .nav a:hover { text-decoration: underline; }
      .nav .right { float: right; color: #bdc3c7; }
      .tag { display: inline-block; padding: 2px 8px; background: #3498db;
             color: white; border-radius: 12px; font-size: 12px; margin: 2px; }
      table { width: 100%; border-collapse: collapse; margin: 10px 0; }
      th, td { padding: 10px 12px; text-align: left; border-bottom: 1px solid #ddd; }
      th { background: #ecf0f1; font-weight: bold; }
      code { background: #ecf0f1; padding: 2px 6px; border-radius: 3px; font-size: 13px; }
      .token-box { display: block; padding: 10px; background: #ecf0f1;
                   border-radius: 4px; word-break: break-all; margin: 10px 0;
                   font-family: monospace; font-size: 12px; }
      footer { margin-top: 40px; color: #999; font-size: 12px; text-align: center; }
    </style>
    """

local Footer := """
    <footer>Powered by MimerCode &mdash; Components4Developers 2026</footer>
    </body></html>
    """

// =============================================
// Public Routes
// =============================================

on Web.Get("/") as Req: UserSearch
  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Home - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/login'>Login</a>
      </div>
      <h1>MimerCode Web Application</h1>
      <div class='card'>
        <h2>Welcome</h2>
        <p>This web application is built entirely in MimerCode, demonstrating:</p>
        <ul>
          <li>Contract-based request validation</li>
          <li>SHA-256 password hashing with salt</li>
          <li>JWT-based authentication</li>
          <li>Role-based authorization (user, editor, admin)</li>
          <li>Sensitive data masking (passwords never visible)</li>
          <li>Threaded HTTP request handling via Indy</li>
        </ul>
        <p><a href='/login' class='btn'>Login to get started</a></p>
      </div>
      <div class='card'>
        <h2>Demo Accounts</h2>
        <table>
          <tr><th>Username</th><th>Password</th><th>Roles</th></tr>
          <tr><td>admin</td><td>admin123</td><td><span class='tag'>admin</span> <span class='tag'>user</span></td></tr>
          <tr><td>kim</td><td>secret123</td><td><span class='tag'>user</span></td></tr>
          <tr><td>anna</td><td>editor456</td><td><span class='tag'>user</span> <span class='tag'>editor</span></td></tr>
        </table>
      </div>
      """
  Html += Footer
  return Html
end

on Web.Get("/login") as Req: UserSearch
  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Login - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/login'>Login</a>
      </div>
      <h1>Login</h1>
      <div class='card'>
        <form method='POST' action='/api/login'>
          <div class='form-group'>
            <label>Username</label>
            <input type='text' name='Username' placeholder='Enter username' required>
          </div>
          <div class='form-group'>
            <label>Password</label>
            <input type='password' name='Password' placeholder='Enter password' required>
          </div>
          <button type='submit' class='btn'>Login</button>
        </form>
        <p style='margin-top: 15px; color: #999;'>
          Try: admin/admin123, kim/secret123, or anna/editor456
        </p>
      </div>
      """
  Html += Footer
  return Html
end

// =============================================
// API Routes
// =============================================

on Web.Post("/api/login") as Req: LoginRequest
  local Username := unseal(Req.Username)
  local Password := unseal(Req.Password)

  local Result := Auth("login", dict{
    "Username": Username,
    "Password": Password
  })

  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Login Result - MimerCode App</title>" + CSS + "</head><body>"

  if Result.Success then
    Html += """
        <div class='nav'>
          <a href='/'>Home</a>
          <a href='/dashboard'>Dashboard</a>
          <a href='/profile'>Profile</a>
        </div>
        """
    Html += "<h1>Login Successful</h1>"
    Html += "<div class='card'>"
    Html += "<div class='alert alert-success'>Welcome back, " + Username + "!</div>"
    Html += "<p>Your session cookie has been set. You can now access protected pages directly.</p>"
    Html += """
        <p>
          <a href='/dashboard' class='btn btn-success'>Dashboard</a>
          <a href='/profile' class='btn'>Profile</a>
          <a href='/admin' class='btn'>Admin Panel</a>
        </p>
        """
    Html += "</div>"

    // Show curl examples
    Html += "<div class='card'>"
    Html += "<h2>API Access (curl)</h2>"
    Html += "<pre style='background:#2c3e50; color:#ecf0f1; padding:15px; border-radius:4px; overflow-x:auto;'>"
    Html += "curl -H \"Authorization: Bearer " + Result.Token + "\" \\\n"
    Html += "     http://localhost:8080/dashboard\n\n"
    Html += "curl -H \"Authorization: Bearer " + Result.Token + "\" \\\n"
    Html += "     http://localhost:8080/admin"
    Html += "</pre></div>"

    Html += Footer
    return HttpResponse {
      Status: 200,
      ContentType: "text/html",
      Body: Html,
      Headers: dict{ "Set-Cookie": "token=" + Result.Token + "; Path=/; HttpOnly; SameSite=Lax" }
    }
  else
    Html += """
        <div class='nav'>
          <a href='/'>Home</a>
          <a href='/login'>Login</a>
        </div>
        <h1>Login Failed</h1>
        <div class='card'>
          <div class='alert alert-error'>Invalid username or password.</div>
          <p><a href='/login' class='btn'>Try Again</a></p>
        </div>
        """
  end

  Html += Footer
  return Html
end

on Web.Get("/api/verify") as Req: UserSearch
  return """
      {"status": "ok", "message": "Token is valid"}
      """
end

on Web.Get("/logout") as Req: UserSearch
  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Logged Out - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/login'>Login</a>
      </div>
      <h1>Logged Out</h1>
      <div class='card'>
        <div class='alert alert-success'>You have been logged out successfully.</div>
        <p><a href='/login' class='btn'>Login Again</a></p>
      </div>
      """
  Html += Footer
  return HttpResponse {
    Status: 200,
    ContentType: "text/html",
    Body: Html,
    Headers: dict{ "Set-Cookie": "token=; Path=/; HttpOnly; SameSite=Lax; Max-Age=0" }
  }
end

// =============================================
// Protected Routes (require authentication)
// =============================================

on Web.Get("/dashboard") as Req: UserProfile
  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Dashboard - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/dashboard'>Dashboard</a>
        <a href='/profile'>Profile</a>
        <a href='/admin'>Admin</a>
      </div>
      <h1>Dashboard</h1>
      <div class='card'>
        <h2>Welcome to your Dashboard</h2>
        <p>This page requires the <span class='tag'>user</span> role.</p>
        <p>If you can see this, your JWT token was verified and you have the correct role.</p>
      </div>
      <div class='card'>
        <h2>Quick Stats</h2>
        <table>
          <tr><th>Metric</th><th>Value</th></tr>
          <tr><td>Server Status</td><td><span class='tag' style='background:#27ae60'>Online</span></td></tr>
          <tr><td>Active Contracts</td><td>7 defined</td></tr>
          <tr><td>Registered Routes</td><td>8 endpoints</td></tr>
          <tr><td>Auth Provider</td><td>JSON file (users.json)</td></tr>
        </table>
      </div>
      """
  Html += Footer
  return Html
end

on Web.Get("/profile") as Req: UserProfile
  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Profile - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/dashboard'>Dashboard</a>
        <a href='/profile'>Profile</a>
      </div>
      <h1>User Profile</h1>
      <div class='card'>
        <h2>Your Information</h2>
        <p>This page requires the <span class='tag'>user</span> role.</p>
        <p>Your identity was verified via the JWT token in the Authorization header.</p>
        <table>
          <tr><th>Field</th><th>Value</th></tr>
          <tr><td>Authentication</td><td>JWT (HS256)</td></tr>
          <tr><td>Token Expiry</td><td>60 minutes</td></tr>
          <tr><td>Password Storage</td><td>SHA-256 + random salt</td></tr>
        </table>
      </div>
      """
  Html += Footer
  return Html
end

// =============================================
// Admin Routes (require admin role)
// =============================================

on Web.Get("/admin") as Req: AdminAction
  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Admin - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/dashboard'>Dashboard</a>
        <a href='/admin'>Admin</a>
        <a href='/admin/users'>Users</a>
      </div>
      <h1>Admin Panel</h1>
      <div class='card'>
        <div class='alert alert-info'>
          This page requires the <span class='tag' style='background:#e74c3c'>admin</span> role.
          Regular users will receive a 403 Forbidden response.
        </div>
        <h2>Administration</h2>
        <p>From here you can manage the application:</p>
        <p>
          <a href='/admin/users' class='btn'>Manage Users</a>
          <a href='/admin/contracts' class='btn'>View Contracts</a>
        </p>
      </div>
      <div class='card'>
        <h2>System Information</h2>
        <table>
          <tr><th>Component</th><th>Status</th></tr>
          <tr><td>HTTP Server</td><td>Indy TIdHTTPServer (threaded)</td></tr>
          <tr><td>Auth Backend</td><td>JSON file (users.json)</td></tr>
          <tr><td>Password Hashing</td><td>SHA-256 + 16-byte random salt</td></tr>
          <tr><td>Token Format</td><td>JWT HS256, 60 min expiry</td></tr>
          <tr><td>Threading</td><td>Per-request TMimerExecContext</td></tr>
          <tr><td>Sensitive Fields</td><td>Sealed (unseal() required)</td></tr>
        </table>
      </div>
      """
  Html += Footer
  return Html
end

on Web.Get("/admin/users") as Req: AdminAction
  // Get all user roles
  local AdminRoles := Auth("roles", "admin")
  local KimRoles := Auth("roles", "kim")
  local AnnaRoles := Auth("roles", "anna")

  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Users - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/dashboard'>Dashboard</a>
        <a href='/admin'>Admin</a>
        <a href='/admin/users'>Users</a>
      </div>
      <h1>User Management</h1>
      <div class='card'>
        <div class='alert alert-info'>
          Requires <span class='tag' style='background:#e74c3c'>admin</span> role.
        </div>
        <h2>Registered Users</h2>
        <table>
          <tr><th>Username</th><th>Roles</th><th>Actions</th></tr>
      """
  Html += "<tr><td>admin</td><td>" + AdminRoles + "</td><td><span class='btn btn-danger' style='padding:4px 10px;font-size:12px;'>Delete</span></td></tr>"
  Html += "<tr><td>kim</td><td>" + KimRoles + "</td><td><span class='btn btn-danger' style='padding:4px 10px;font-size:12px;'>Delete</span></td></tr>"
  Html += "<tr><td>anna</td><td>" + AnnaRoles + "</td><td><span class='btn btn-danger' style='padding:4px 10px;font-size:12px;'>Delete</span></td></tr>"
  Html += """
        </table>
      </div>
      <div class='card'>
        <h2>Authorization Flow</h2>
        <p>When a request hits a protected endpoint:</p>
        <ol>
          <li>Indy receives the HTTP request on a worker thread</li>
          <li>The <code>Authorization: Bearer &lt;jwt&gt;</code> header is extracted</li>
          <li>The JWT signature is verified using HMAC-SHA256</li>
          <li>Token expiry is checked</li>
          <li>Roles are extracted from the JWT payload</li>
          <li>The <code>requires</code> clause on the input contract is evaluated</li>
          <li>If authorized: handler body executes in a per-request context</li>
          <li>If unauthorized: HTTP 403 is returned immediately</li>
        </ol>
      </div>
      """
  Html += Footer
  return Html
end

on Web.Get("/admin/contracts") as Req: AdminAction
  local Html := "<!DOCTYPE html><html><head><meta charset='utf-8'>"
  Html += "<title>Contracts - MimerCode App</title>" + CSS + "</head><body>"
  Html += """
      <div class='nav'>
        <a href='/'>Home</a>
        <a href='/dashboard'>Dashboard</a>
        <a href='/admin'>Admin</a>
        <a href='/admin/users'>Users</a>
      </div>
      <h1>Contract Definitions</h1>
      <div class='card'>
        <h2>Active Contracts</h2>
        <table>
          <tr><th>Contract</th><th>Fields</th><th>Auth Required</th></tr>
          <tr><td>LoginRequest</td><td>Username (required), Password (required, sensitive)</td><td>None</td></tr>
          <tr><td>UserProfile</td><td>UserId (optional)</td><td><span class='tag'>user</span></td></tr>
          <tr><td>AdminAction</td><td>Action (optional)</td><td><span class='tag' style='background:#e74c3c'>admin</span></td></tr>
          <tr><td>UserSearch</td><td>Name (optional, like), Page (default 1)</td><td>None</td></tr>
          <tr><td>NewUser</td><td>Username, Password (sensitive), Role</td><td><span class='tag' style='background:#e74c3c'>admin</span></td></tr>
        </table>
      </div>
      """
  Html += Footer
  return Html
end

// =============================================
// Start
// =============================================

WriteLn("")
WriteLn("=== MimerCode Web Application Running ===")
WriteLn("URL: http://localhost:8080")
WriteLn("")
WriteLn("Pages:")
WriteLn("  http://localhost:8080/          Home (public)")
WriteLn("  http://localhost:8080/login     Login form (public)")
WriteLn("  http://localhost:8080/dashboard Dashboard (requires user role)")
WriteLn("  http://localhost:8080/profile   Profile (requires user role)")
WriteLn("  http://localhost:8080/admin     Admin panel (requires admin role)")
WriteLn("")
WriteLn("Demo accounts: admin/admin123, kim/secret123, anna/editor456")
WriteLn("")
WriteLn("Press Enter to stop the server...")
ReadLn()

close(Web)
WriteLn("Server stopped.")
