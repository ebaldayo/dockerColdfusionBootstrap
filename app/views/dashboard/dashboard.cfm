
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ColdFusion + Bootstrap Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      overflow-x: hidden;
    }
    .sidebar {
      min-height: 100vh;
      background-color: #f8f9fa;
    }
  </style>
</head>
<body>

  <!-- Top Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
    <a class="navbar-brand" href="#">Mi App CF</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="#">Perfil</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Salir</a>
        </li>
      </ul>
    </div>
  </nav>

  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <div class="col-md-2 sidebar p-3">
        <h5>Opciones</h5>
        <ul class="nav flex-column">
          <li class="nav-item"><a class="nav-link" href="#">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Usuarios</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Reportes</a></li>
        </ul>
      </div>

      <!-- Main Content -->
      <div class="col-md-10 p-4">
        <h2>Bienvenido</h2>
        <p>Este es el layout base de tu proyecto ColdFusion + Bootstrap.</p>

        <div class="card mt-4">
          <div class="card-body">
            <h5 class="card-title">Bloque de contenido</h5>
            <p class="card-text">Aqui los datos, formularios o resultados.</p>
            <a href="#" class="btn btn-primary">Enviar</a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>