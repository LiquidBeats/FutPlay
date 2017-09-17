window.fbAsyncInit = function() {
    FB.init({
      appId            : '147631892478300',
      autoLogAppEvents : true,
      xfbml            : true,
      version          : 'v2.10'
    });
    
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
      
  };

  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }
  
  function statusChangeCallback(response){
      if(response.status === "connected"){
          FB.api("/me", { access_token : response.authResponse.accessToken },{fields: ['first_name', 'last_name', 'email', 'birthday', 'gender', 'picture.width(300).height(300)']},function(response){
             if(response && !response.error){
                $.ajax({
                   url:"/FutPlayFinal/inicio/facebook",
                   method:"post",
                   dataType:"json",
                   data:{email:response.email},
                   complete:function(data){
                        if(data.responseText==="1"){
                            window.location.href = "/FutPlayFinal/material-dashboard/pages/propietario/indexPropietario.jsp";
                        }
                        else if(data.responseText==="2"){
                            window.location.href = "/FutPlayFinal/material-dashboard/pages/jugador/indexJugador.jsp";
                        }
                        else{
                            $("#modalRuta").modal("show");
                            $(".btnPropFacebook").on("click",function(){
                                var gender = response.gender;
                                var genero="";
                                if(gender==="male"){
                                    genero="Masculino";
                                }
                                else{
                                    genero="Femenino";
                                }
                               $.ajax({
                                  url:"/FutPlayFinal/usuario/registrar",
                                  method:"post",
                                  dataType:"json",
                                  data:{UNombre:response.first_name,UApellido:response.last_name,UFechaNacimiento:response.birthday,UTelefono:"",UGenero:genero,UCorreo:response.email,UContrasenia:"",UAvatar:response.picture.data.url},
                                  success: function(data){
                                      if(data>"0"){
                                          $.ajax({
                                              url:"/FutPlayFinal/propietario/registrar",
                                              method:"post",
                                              dataType:"json",
                                              data:{UCorreo:response.email}
                                          }).done(function(data){
                                            if(data>"0"){
                                                swal({
                                                   title:"Bienvenido",
                                                   text:"Disfruta de la experiencia futplay!",
                                                   type:"success",
                                                   confirmButtonText:"Aceptar",
                                                   preConfirm:function(){
                                                       window.location.href="/FutPlayFinal/material-dashboard/pages/propietario/indexPropietario.jsp";
                                                   }
                                                }); 
                                            }
                                            else{
                                                swal("Error","Ocurrio un error al momento de procesar la solicitud","error");
                                            }
                                          });
                                      }
                                      else{
                                          swal("Error","Ocurrio un error al momento de procesar la solicitud","error");
                                      }
                                  }
                               });
                            });
                            $(".btnJugFacebook").on("click",function(){
                                var gender = response.gender;
                                var genero="";
                                if(gender==="male"){
                                    genero = "Masculino";
                                }
                                else if(gender==="female"){
                                    genero = "Femenino";
                                }
                                else if(gender==="Hombre"){
                                    genero = "Masculino";
                                }
                                else if(gender==="Mujer"){
                                    genero = "Femenino";
                                }
                                var UNombre = response.first_name;
                                var UApellido = response.last_name;
                                var UFechaNacimiento = response.birthday;
                                var UTelefono = "";
                                var UCorreo = response.email;
                                var UContrasenia = "";
                                var UAvatar = response.picture.data.url;
                                localStorage.setItem('JSONFacebook', JSON.stringify({UNombre:UNombre,UApellido:UApellido,UFechaNacimiento:UFechaNacimiento,UTelefono:UTelefono,UCorreo:UCorreo,UContrasenia:UContrasenia,UAvatar:UAvatar,genero:genero}));
                                window.location.href = "/FutPlayFinal/material-dashboard/pages/jugador/completarPerfilFB.jsp";
                            });
                        }
                   }
                });
             } 
          });
      }
  }
  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "https://connect.facebook.net/en_US/all.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
   
  $("#loginBtn").on("click",function(){
    FB.login(function(response) {
        statusChangeCallback(response);
    },{scope: 'public_profile,email,user_birthday'});
  });