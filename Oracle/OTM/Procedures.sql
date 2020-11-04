/* Insere uma quantidade X de registros na tabela funcionario*/
CREATE OR REPLACE PROCEDURE SP_INSERIR_FUNCIONARIOS 
(
	PQTDE_REG INTEGER
)
	AS

	vCONT INTEGER;
	VSEXO CHAR;
  VESTADOCIVIL CHAR;
  
	BEGIN

      VCONT := 1;
	    VSEXO := 'M';
      vEstadoCivil := 'S';

      WHILE (VCONT < PQTDE_REG) LOOP

         INSERT INTO TB_FUNCIONARIO VALUES
              (	VCONT,
			          'EMPREGADO' || vCONT,
			          'AVENIDA DAS AMERICAS',
          			0,
			          'S/N',
			          'MUSSURUNGA',
			          1,
          			'40000000',
			          'EM FRENTE AO ESPORTE CLUBE MUSSURUNGA',
			          '7134560969',
			          'ESPORTECLUBEMUSURUNGA@MUSSURUNGA.COM.BR',
			          VSEXO,
			          vEstadoCivil,
			          to_date('01/01/1980', 'dd/mm/yyyy'),
			          '12345678901',
			          to_date('01/01/2000', 'dd/mm/yyyy'),
			          NULL
               );

	        IF (vEstadoCivil = 'S') THEN
		        vEstadoCivil := 'C';
	        ELSE
		        vEstadoCivil := 'S';
          END IF;

	        IF (vCont in (10, 100, 300, 500, 700, 1000, 1500, 2000, 4000, 6500)) THEN
		        vSEXO := 'M';
	        ELSE
		        vSEXO := 'F';
          END IF;

	        VCONT := VCONT +1;

        END LOOP;
	END;
  
  /* Insere uma quantidade X de registros na tabela historico para os
    funcionarios já cadastrados. Do ano de 2010*/

CREATE OR REPLACE PROCEDURE SP_INSERIR_HISTORICO
AS

 VANO INTEGER;
 VMES INTEGER;
 vCARGO INTEGER;
 VSETOR INTEGER;
 vSALARIO INTEGER;
 VHORAS INTEGER;

BEGIN

      VANO := 2010;
      vMES := 1;
      VCARGO := 1;
      VSETOR := 1;
      VSALARIO := 3500;
	    vHORAS := 120;


      WHILE (vANO <= 2010) LOOP

           WHILE (vMES < 13) LOOP

              INSERT INTO TB_HISTORICO
                  SELECT
	              		VANO,
			              vMES,
			              MATRICULA,
			              vCARGO,
			              VSETOR,
			              vHORAS,
			              VSALARIO
                  FROM TB_FUNCIONARIO;

		          VMES := VMES +1;
              vSALARIO := vSALARIO +50;

           END LOOP;

           VANO := VANO +1;
           VCARGO := VCARGO +1;
           VSETOR :=  VSETOR +1;
           vMES := 1;


    	     IF (VHORAS = 120) THEN
	            VHORAS := 180;
	         ELSE
            IF (VHORAS = 180) THEN
	              vHORAS := 220;
	          ELSE
	              vHORAS := 120;
            END IF;
           END IF;

     END LOOP;

END;
