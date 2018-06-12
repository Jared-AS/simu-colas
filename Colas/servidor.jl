module Servidor

import Generadores

tiempoPromedioDeServicio = 5
tiempoDeServicio = 0
ocupado = false
clienteNro = 0

function nextStep()
    if(ocupado)
        global tiempoDeServicio -= 1
        if(tiempoDeServicio == 0)
            global ocupado = false
            println("El cliente ", clienteNro," sale del servidor")
            println()
        end
    end  
end

function atenderCliente(c)
    global clienteNro = c.numero
    generarTiempoServicio()
    global ocupado = true 
    println("El cliente ", clienteNro, " entra a ser atendido por el servidor, tiempo de atencion: ", tiempoDeServicio)    
    println()
end

function generarTiempoServicio()
    global tiempoDeServicio = Generadores.generadorExponencial(tiempoPromedioDeServicio)
end

function mostrarEstado()
    println("Servidor: ")
    if(ocupado)
        println("cliente actual: ", clienteNro)
        println("tiempo faltante de servicio: ", tiempoDeServicio)
    else
        println("libre")
    end
end
end