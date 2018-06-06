module Generadores

x = 7
r = 0
n = 0

# generador de variables aleatorias con generador multiplicativo
function nextRandom()
    global x = mod(5 * x, 64)
    global r = round(x / 64, 7)
end

#modelo del cliente
struct Cliente
    numero
    tiempoLlegada
    tiempoEspera
end

#generador de clientes
function nextClient()
    global n += 1
    sgteLlegada = siguienteLlegada()
    if(esperaEnCola())
        return Cliente(n, sgteLlegada, -1)
    else
        tiempoEspera = getTiempoEspera()
        return Cliente(n, sgteLlegada, tiempoEspera)
    end
end

#generador con distribucion bernoulli
function esperaEnCola()
    nextRandom()
    return r < 0.5 ? true : false
end

#generador con distribucion exponencial
function siguienteLlegada()
    promedio = 2
    return generadorExponencial(promedio)
end

#generador con distribucion uniforme continua
function getTiempoEspera()
    a = 30
    b = 45
    nextRandom()
    return round(a + r * (b - a))
end

function generadorExponencial(promedio)
    nextRandom()    
    t = round(-promedio * log(r))
    return t < 1 ? 1.0 : t
end

end