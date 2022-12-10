<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>Music Recommendations</title>
</head>
<body class="min-vh-100 d-flex flex-column">
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              ...
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
          </div>
        </div>
      </div>
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container px-4 px-lg-5">
            <a class="navbar-brand" href="#!">Music Recommendations</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#!">Lists</a></li>
                </ul>
                <a class="d-flex btn btn-outline-dark" href="/profile">Profile</a>
            </div>
        </div>
    </nav>
    <!-- Header-->
    <header class="py-3" style="background: rgb(161,34,167);
    background: linear-gradient(90deg, rgba(161,34,167,1) 0%, rgba(208,29,72,1) 50%, rgba(0,212,255,1) 100%);">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">{{username}}'s Lists</h1>
            </div>
        </div>
    </header>
    <!-- Section-->
    <section class="py-5 flex-grow-1">
        <div class="container px-4 px-lg-5 mt-5">
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                <div class="col mb-5">
                    <div class="card h-100">
                        <!-- Product details-->
                        <div class="card-body p-4 bg-light" style="cursor: pointer;" onclick="modal_toggle()">
                            <div class="text-center">
                                <h1 class="fw-bolder">+</h1>
                            </div>
                        </div>
                    </div>
                </div>
                % for list in lists:
                <div class="col mb-5">
                    <div class="card h-100">
                        <!-- Product image-->
                        <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                        <!-- Product details-->
                        <div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder h2">{{ list[2] }}</h5>
                            </div>
                        </div>
                            <form action="/list/delete/{{ list[0] }}" method="post" class="btn-group card-footer bg-transparent" role="group" aria-label="Basic example">
                                <button type="button" class="btn btn-primary">View</button>
                                <input class="btn btn-danger" Value="Delete" type="reset" onclick="deleteList({{ list[0] }});"/>
                            </form>
                    </div>
                </div>
                % end
            </div>
        </div>
    </section>
    <!-- Footer-->
    <footer class="py-2" style="background: rgb(161,34,167);
    background: linear-gradient(90deg, rgba(161,34,167,1) 0%, rgba(208,29,72,1) 50%, rgba(0,212,255,1) 100%);">
        <div class="container"><p class="m-0 text-center text-white">Music Recommendations @Axel-PJ</p></div>
    </footer>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script type="text/javascript" src="/static/js/main.js" charset="utf-8"></script>
</body>

</html>