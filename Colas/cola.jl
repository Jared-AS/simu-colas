include("../Generadores/generadores.jl")
include("./servidor.jl")
import Generadores, Servidor
using DataStructures

clientes = Queue(Any)
siguienteCliente = Generadores.nextClient()
enqueue!(clientes, siguienteCliente)

tiempo = siguienteCliente.tiempoLlegada
tiempoSimulacion = 100

function mostrarCliente(c)
    println(c.numero, " ", c.tiempoLlegada, " ", c.tiempoEspera, "   t=", tiempo, " serv: ", Servidor.tiempoDeServicio)
end

function entraSiguienteCliente()
    cliente = front(clientes)
    return !Servidor.ocupado && cliente != nothing
end

function nextStep()
    global tiempo += 1
end

while tiempo < tiempoSimulacion
    Servidor.nextStep()
    nextStep()
    if(entraSiguienteCliente())
        Servidor.atenderCliente()
        mostrarCliente(Generadores.nextClient())
    end

end

