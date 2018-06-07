include("../Generadores/generadores.jl")
include("./servidor.jl")
import Generadores, Servidor
using DataStructures

clientes = Queue(Any)
siguienteCliente = Generadores.nextClient()
tiempoLlegadaSiguienteCliente = siguienteCliente.tiempoLlegada

tiempo = siguienteCliente.tiempoLlegada
tiempoSimulacion = 100

function mostrarCliente(c)
    println("clienteNo:", c.numero, " tLlegada: ", c.tiempoLlegada, " tEspera:", c.tiempoEspera)
end

function entraSiguienteCliente()
    return !Servidor.ocupado && !isempty(clientes)
end

function mostrarEstadoSistema()
    println("-----------------------------------------")
    println("tiempo sistema: ", tiempo)
    print("cola: ")
    if(!isempty(clientes))
        for cliente in clientes
            print(cliente.numero, " ")
        end
    else
        print("no hay clientes en la cola")
    end
    println("")
    println("")

end

function nextStep()
    mostrarEstadoSistema()    
    global tiempo += 1
    global tiempoLlegadaSiguienteCliente -= 1
    if(tiempoLlegadaSiguienteCliente == 0)
        enqueue!(clientes, siguienteCliente)
        println("El cliente ", siguienteCliente.numero, " entra a la cola.")
        global siguienteCliente = Generadores.nextClient()
        tiempoLlegadaSiguienteCliente = siguienteCliente.tiempoLlegada
        println("El cliente ", siguienteCliente.numero, " llega en: ", tiempoLlegadaSiguienteCliente)
        println()
    end
end

while tiempo <= tiempoSimulacion
    nextStep()
    Servidor.nextStep()
    if(entraSiguienteCliente())
        x = dequeue!(clientes)
        Servidor.atenderCliente(x)
        #mostrarCliente(x)
    end

end

