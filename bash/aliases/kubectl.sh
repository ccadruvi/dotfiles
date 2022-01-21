
function k(){
  kubectl $@
}

function kg(){
  k get $@
}

function kdesc(){
  k describe $@
}

function kdel(){
  k delete $@
}
