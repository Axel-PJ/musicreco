<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<title>Register</title>
</head>
<body>
  <section class="vh-100">
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-6 text-black">
  
          <div class="px-5 ms-xl-4">
            <i class="fas fa-crow fa-2x me-3 pt-5 mt-xl-4" style="color: #709085;"></i>
            <span class="h1 fw-bold mb-0">Logo</span>
          </div>
  
          <div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">
  
            <form action="/register" method="post" style="width: 23rem;">
  
              <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Register</h3>
  
              <div class="form-outline mb-4">
                <input type="email" name="username" id="form2Example18" class="form-control form-control-lg" />
                <label class="form-label" for="form2Example18">Email address</label>
              </div>
  
              <div class="form-outline mb-4">
                <input type="password" name="password" id="form2Example28" class="form-control form-control-lg" />
                <label class="form-label" for="form2Example28">Password</label>
              </div>
  
              <div class="pt-1 mb-4">
                <input class="btn btn-info btn-lg btn-block" value="Register" type="submit" />
              </div>
  
            </form>
  
          </div>
  
        </div>
        <div class="col-sm-6 px-0 d-none d-sm-block">
          <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/img3.webp"
            alt="Login image" class="w-100 vh-100" style="object-fit: cover; object-position: left;">
        </div>
      </div>
    </div>
  </section>
</body>
</html>