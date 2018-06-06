include("./Generadores/generadores.jl")
import Generadores
using DataStructures

q = Queue(Int)
enqueue!(q, 1)
enqueue!(q, 2)
x = dequeue!(q)

print(x)

function getNextClient()
    c = Generadores.nextClient()
    return c
end

function mostrarCliente(c)
    println(c.numero)
    println(c.tiempoLlegada)
    println(c.tiempoEspera)
    println()
end

i = 10
while i > 0
    mostrarCliente(getNextClient())
    i -= 1
end