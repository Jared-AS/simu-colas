module Servidor

import Generadores

tiempoPromedioDeServicio = 5
tiempoDeServicio = 0
ocupado = false

function nextStep()
    if(ocupado)
        global tiempoDeServicio -= 1
        if(tiempoDeServicio == 0)
            global ocupado = false
        end
    end  
end

function atenderCliente()
    generarTiempoServicio()
    global ocupado = true 
end

function generarTiempoServicio()
    global tiempoDeServicio = Generadores.generadorExponencial(tiempoPromedioDeServicio)
end

end