include("../Generadores/generadores.jl")
include("./servidor.jl")
import Generadores, Servidor
using DataStructures, HypothesisTests

clientes = Queue(Any)
siguienteCliente = Generadores.nextClient()
tiempoLlegadaSiguienteCliente = siguienteCliente.tiempoLlegada
tiempoEnCola = zeros(100)

tiempo = siguienteCliente.tiempoLlegada
tiempoSimulacion = 50

function mostrarCliente(c)
    println("clienteNo:", c.numero, " tLlegada: ", c.tiempoLlegada, " tEspera:", c.tiempoEspera)
end

function entraSiguienteCliente()
    return !Servidor.ocupado && !isempty(clientes)
end

function mostrarEstadoSistema()
    println("####################################################################################")
    println("tiempo sistema: ", tiempo)
    println("--------------------------------------")
    println("cola de espera: ")
    if(!isempty(clientes))
        for cliente in clientes
            print(cliente.numero, " ")
        end
    else
        print("no hay clientes en la cola")
    end
    println("")
    println("--------------------------------------")    
    Servidor.mostrarEstado()
    println("--------------------------------------")
end

function quitarDeLaCola(numero)
    aux = Queue(Any)
    for cliente in clientes
        if(cliente.numero != numero)
            enqueue!(aux, cliente)
        end
    end
    global clientes = aux;
end

function determinarTiempoEnCola()
    for cliente in clientes
        tiempoEnCola[cliente.numero] += 1;
        if (cliente.tiempoEspera > 0 && (tiempoEnCola[cliente.numero] > cliente.tiempoEspera))
            println("cliente ", cliente.numero, " abandonda la cola luego de esperar ", cliente.tiempoEspera)
            quitarDeLaCola(cliente.numero);
        end
    end
end

function nextStep()
    determinarTiempoEnCola()
    mostrarEstadoSistema()    
    global tiempo += 1
    global tiempoLlegadaSiguienteCliente -= 1
    if(tiempoLlegadaSiguienteCliente == 0)
        enqueue!(clientes, siguienteCliente)
        println("El cliente ", siguienteCliente.numero, " entra a la cola.")
        global siguienteCliente = Generadores.nextClient()
        tiempoLlegadaSiguienteCliente = siguienteCliente.tiempoLlegada
        println("El cliente ", siguienteCliente.numero, " llega en: ", tiempoLlegadaSiguienteCliente)
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
    #@time sleep(2)
end

println("####################################################################################")
tiempoEnCola = tiempoEnCola[1:siguienteCliente.numero-1]
println("Intervalo de confianza del 95% para tiempo de espera en cola: ")
println(confint(OneSampleTTest(tiempoEnCola), 0.05))