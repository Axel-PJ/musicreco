function deleteList(id) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "list/delete/"+id, true);
    xhr.send();
    xhr.onload = function() {
        console.log(this.responseText);
      }
}