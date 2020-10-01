-- Criando um package que funciona como uma biblioteca
CREATE OR REPLACE PACKAGE PK_TESTE AS
    cPI CONSTANT NUMBER := 3.1416;
    FUNCTION FC_CALCULA_AREA(pBase NUMBER, pAltura NUMBER) RETURN NUMBER;
    -- Fazendo sobrecarga
    FUNCTION FC_CALCULA_AREA(pRaio NUMBER) RETURN NUMBER;
END;

-- Implementando as funcoes do pacote
CREATE OR REPLACE PACKAGE BODY PK_TESTE AS

    FUNCTION FC_CALCULA_AREA(pBase NUMBER, pAltura NUMBER)
    RETURN NUMBER
    IS
    BEGIN
        RETURN pBase * pAltura;
    END;
    
        FUNCTION FC_CALCULA_AREA(pRaio NUMBER)
    RETURN NUMBER
    IS
    BEGIN
        RETURN cPI * pRaio;
    END;
    
END;

-- Chamando uma funcao de dentro do pacote
DECLARE
    vArea NUMBER;
    vAreaCirculo NUMBER;
BEGIN
    vArea := PK_TESTE.FC_CALCULA_AREA(5,4);
    DBMS_OUTPUT.PUT_LINE('A area da figura eh: ' || vArea);
    vAreaCirculo := PK_TESTE.FC_CALCULA_AREA(3);
    DBMS_OUTPUT.PUT_LINE('A area do circulo eh: ' || vAreaCirculo);
END;