module Name
    function sum(a, b)
        return a + b
    end

    function multiply(a,b)
        return a * b
    end

    function nextRandom(x0)
        x0 = mod(5*x0, 64)
        return round(x0/64, 5)
    end
end