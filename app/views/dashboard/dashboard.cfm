
<html lang="en">
<cfinclude template="../layouts/head.cfm" >
<body>

  <!-- Top Navigation Bar -->
  <cfinclude template="../layouts/top-navigation-bar.cfm" >

  <div class="container-fluid">
    <cfinclude template="../layouts/sidebar.cfm" >

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