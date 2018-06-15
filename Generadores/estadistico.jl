module Estadistico

    function maxMin(muestra)
        max = maximum(muestra)
        min = minimum(muestra)
        return (max, min)
    end

    function media(muestra)
        suma = 0
        for m in muestra
            suma += m
        end
        return suma/length(muestra)
    end

    function moda(muestra)
        maxNum = -1
        maxFrec = -1
        for i in muestra
            frec = 0
            for j in muestra
                if(i == j)
                    frec += 1
                end
            end
            if(frec > maxFrec)
                maxNum = i
            end
        end
        return maxNum
    end

    function varianza(muestra)
        lamedia = media(muestra)
        sum = 0
        for i in muestra
            sum += (lamedia - i)^2
        end
        return sum/length(muestra)
    end

    function datosCola(promedioLlegada, promedioServicio)
        delta = 1/promedioLlegada
        nano = 1/promedioServicio
        p = delta/nano
        p0 = 1 - p
        L = p/(1-p)
        Lq = L - (1 - p0)
        w = L/delta
        wq = Lq/delta

        println("Tiempo promedio de llegadas: ", promedioLlegada)
        println("Taza promedio de llegadas: ", delta)
        println("Tiempo promedio de servicio: ", promedioServicio)
        println("Taza promedio de servicio: ", nano)
        println("Proporcion o porcentaje de utilizacion del sistema: ", p)
        println("Longitud promedio de clientes en el sistema: ", L)
        println("Longitud promedio de clientes en la cola: ", Lq)
        println("Tiempo promedio de permanencia de un cliente en el sistema E(W): ", w)
        println("Tiempo promedio de permanencia de un cliente en la cola E(Wq): ", wq)
        println("Probabilidad de que el tiempo de espera en la cola sea 0: ", p0)
    end

    function datos(muestra, promedioLlegada, promedioServicio, intervConf)
        maxmin = maxMin(muestra)
        println()
        println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
        println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
        println()
        println("Tiempo minimo de espera en la cola: ", maxmin[2])
        println("Tiempo maximo de espera en la cola: ", maxmin[1])
        println("Media: ", media(muestra))
        println("Moda: ", moda(muestra))
        println("Varianza: ", varianza(muestra))
        println("--------------------------------------------------------------------------")
        datosCola(promedioLlegada, promedioServicio)
        println("Intervalo de confianza del 95% para tiempo de espera en cola: ", intervConf)
    end
end