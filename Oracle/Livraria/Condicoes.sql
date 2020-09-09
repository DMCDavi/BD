DECLARE
    vLado1 number;
    vLado2 number;
    vLado3 number;
BEGIN
    vLado1 := 1;
    vLado2 := 3;
    vLado3 := 2;
    IF ( (vLado1 = vLado2) AND ( vLado1 = vLado3 ) ) THEN
        DBMS_OUTPUT.PUT_LINE('O triangulo eh equilatero');
    ELSIF ( (vLado1 <> vLado2) AND ( vLado1 <> vLado3 ) AND ( vLado2 <> vLado3 ) ) THEN
        DBMS_OUTPUT.PUT_LINE('O triangulo eh escaleno');
    ELSE
        DBMS_OUTPUT.PUT_LINE('O triangulo eh isosceles');
    END IF;
END;

DECLARE
    vEstCivil char(01);
BEGIN
    vEstCivil := 'C';
    CASE vEstCivil
        WHEN 'S' THEN
            DBMS_OUTPUT.PUT_LINE('Solteiro');
        WHEN 'C' THEN
            DBMS_OUTPUT.PUT_LINE('Casado');
        WHEN 'V' THEN
            DBMS_OUTPUT.PUT_LINE('Viuvo');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Outros');
    END CASE;
END;

DECLARE
    x number := 5;
    y number := null;
BEGIN
    -- Troca o valor de y para 0 caso ele seja null
    -- y := NVL(y, 0);
    IF x != y THEN
        DBMS_OUTPUT.PUT_LINE('x eh diferente de y');
    ELSIF x = y THEN
        DBMS_OUTPUT.PUT_LINE('x eh iagual a y');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Indefinido');
    END IF;
END;