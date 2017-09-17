$(document).ready(function(){
/* inicializa el calendario */
    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'agendaWeek',
        titleFormat:"MMMM YYYY",
        columnFormat:"ddd D",
        slotLabelFormat:"h (:mm)a",
        editable:true,
        droppable:true,
        eventOverlap:false,
        eventDrop: function(event, delta, revertFunc) {
            var id = event._id;
            var title = event.title;
            var start = event.start.format();
            var end = event.end.format();
            var color = $(this).css("background-color");
            var campo = $("#cmbCampos").val();
            $.ajax({
                url:"/FutPlayFinal/canchas/guardarEncuentro",
                method:"post",
                data:{id:id,title:title,start:start,end:end,color:color,campo:campo}
            }).done(function(rt){
                if(rt>"0"){
                    $.notify({
                        icon: "check",
                        message: "Evento guardado exitosamente"

                    },{
                        type: 'success',
                        timer: 2500,
                        placement: {
                            from: 'bottom',
                            align: 'right'
                        }
                    });  
                }
                else{
                    $.notify({
                        icon: "sentiment_very_dissatisfied",
                        message: "Ocurrio un error al momento de procesar la solicitud"

                    },{
                        type: 'danger',
                        timer: 2500,
                        placement: {
                            from: 'bottom',
                            align: 'right'
                        }
                    });
                }
            });
        },
        eventResize : function( event, jsEvent, ui, view ){
            var id =  event._id;
            var title = event.title;
            var start = event.start.format();
            var end = event.end.format();
            var color = $(this).css("background-color");
            var campo =$("#cmbCampos").val();
            $.ajax({
                url:"/FutPlayFinal/canchas/guardarEncuentro",
                method:"post",
                data:{id:id,title:title,start:start,end:end,color:color,campo:campo}
            }).done(function(rt){
                if(rt>"0"){
                    $.notify({
                        icon: "check",
                        message: "Evento guardado exitosamente"

                    },{
                        type: 'success',
                        timer: 2500,
                        placement: {
                            from: 'bottom',
                            align: 'right'
                        }
                    });  
                }
                else{
                    $.notify({
                        icon: "sentiment_very_dissatisfied",
                        message: "Ocurrio un error al momento de procesar la solicitud"

                    },{
                        type: 'danger',
                        timer: 2500,
                        placement: {
                            from: 'bottom',
                            align: 'right'
                        }
                    });
                }
            });
        },
        eventClick: function(calEvent, jsEvent, view) {
           var idcampo = $("#cmbCampos").val();
           var idevento = calEvent._id;
           swal({
               title:"Advertencia",
               text:"Deseas eliminar el siguiente evento?",
               type:"warning",
               showCancelButton:true,
               showLoaderOnConfirm:true,
               confirmButtonColor: "#DD6B55", 
               cancelButtonText:"Cancelar",
               confirmButtonText:"Sí",
               preConfirm: function(){
                   setTimeout(function(){
                       $.ajax({
                           url:"/FutPlayFinal/canchas/eliminarEvento",
                           type:"post",
                           data:{idevento:idevento}
                       }).done(function(rt){
                          if(rt>"0"){
                              swal("Excelente","Evento eliminado exitosamente","success");
                              recargarEventos(idcampo);
                          } 
                          else{
                              swal("Error","Ocurrio un error al momento de procesar la solicitud!","error");
                          }
                       });
                   },2000);
               }              
           });
       }
    }); 
/* Funcion para recargar los eventos*/
    function recargarEventos(idCampo){
        var events = {
           url: "/FutPlayFinal/canchas/getJSONEncuentros/"+idCampo+"",
           type: 'POST'         
        };
        $("#calendar").fullCalendar('removeEvents');
        $('#calendar').fullCalendar('addEventSource', events);
    }
/* actualiza los eventos del calendario y carga las canchas de cada campo*/
    $("#cmbCampos").on("change",function(){
        var campo = $(this).val();
        recargarEventos(campo);        
        
        $("#cardEvents").children().remove();
        $.ajax({
           url:"/FutPlayFinal/canchas/getJSONCancha",
           method:"post",
           dataType:"json",
           data:{campo:campo}
        }).done(function(data){
            for (var i = 0; i < data.canchas.length; i++) {
                $("#cardEvents").append("<div class='fc-event btn btn-round btn-xs' style='background-color:#48A44C;'>"+data.canchas[i]+"</div>");
                //asignar atributo droppable a cada evento;
                asignarDroppable($("#cardEvents").children()); 
            }
        });
    });
/*funcion para asignar atributos a los fc-events despues de ser cargados en el DOM*/
    function asignarDroppable(eventoHijo){
        $.each(eventoHijo,function(){
            $(this).draggable({
                zIndex: 999,
                revert: true,      
                revertDuration: 0  
            });
            $(this).data('event', {
                title: $(this).html(),
                stick: true,
                color: "#F44336"
            }); 
        });
    }
});

