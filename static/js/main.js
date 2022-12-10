

function deleteList(id) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "list/delete/"+id, false);
    xhr.send();
    xhr.onload = function() {
        console.log(this.responseText);
      }
    location.reload()
}

function addList() {
  var xhr = new XMLHttpRequest();
  xhr.open("POST", "list", false);
  xhr.send();
  xhr.onload = function() {
      console.log(this.responseText);
    }
}

function modal_toggle() {
  $('#exampleModal').modal('toggle')
}

