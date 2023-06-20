-- -----------------------------------Nuno

-- | Os funcionários devem ser capazes de, a qualquer momento, aceder à ficha dos animais tendo em conta o seu id
-- | Query1
	
DELIMITER &&  
CREATE PROCEDURE busca_animal (IN id_animal INT)  
BEGIN 
    SELECT * FROM animal 
    WHERE id = id_animal; -- id varia em função do animal
END &&  
DELIMITER ;  

-- | Os funcionários devem conseguir obter uma lista com todos os animais sem dono ordenados por data de chegada
-- | Query2

	SELECT id,Nome,Categoria,`Raça e espécie` FROM animal 
		WHERE Adotante_Id IS NULL
        ORDER BY D_chegada ASC;
        
            
-- | Os administradores e os funcionários deverão poder listar os donativos por intervalos de tempo de validade ordenados por prazo mais perto de expirar
-- | Query3

DELIMITER $$
CREATE PROCEDURE listar_donativos(IN date1 DATE, IN date2 DATE)
BEGIN
    SELECT * FROM Donativo
    WHERE Donativo.D_validade BETWEEN date1 AND date2 or Donativo.D_validade AND Donativo.D_validade IS NOT NULL
	ORDER BY Donativo.D_validade ASC;
END $$
DELIMITER ;
       
-- | A quantidade dos produtos deverá poder ser atualizada pelos funcionários
-- | Query4

DELIMITER &&  
CREATE PROCEDURE consumo_donativo (IN id_donativo INT, IN quant DOUBLE)  
BEGIN 
DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O Donativo não existe no sistema' AS Resultado;
    END;

    START TRANSACTION;
    UPDATE donativo 
    SET Quantidade = Quantidade - quant
    WHERE
    id = id_donativo AND D_validade IS NOT NULL;
    Commit;
END &&  
DELIMITER ; 

-- | Os funcionários devem conseguir aceder às informações dos adotantes através de um contacto do adotante
-- | Query5

DELIMITER &&  
CREATE PROCEDURE busca_adotante (IN numTel INT)
BEGIN
   SELECT Adotante.Nome,Adotante.D_nascimento as "Data de Nascimento",Adotante.N_Porta as "Número da Porta",Adotante.Rua, Adotante.CódigoPostal  FROM Contacto
   INNER JOIN Adotante ON Contacto.Adotante_Id = Adotante.Id
   WHERE Contacto.Número = numTel;
END && 
DELIMITER ; 

-- | A qualquer momento, os funcionários devem conseguir obter o capital da associação 
-- | Query6

SELECT SUM(Donativo.Quantidade) AS Capital FROM Donativo
LEFT JOIN comprovativo ON comprovativo.Donativo_id = Donativo.id
WHERE comprovativo.Donativo_id IS NOT NULL;
        
-- | Os administradores devem conseguir visualizar se um adotante é também doador
-- | Query7
       
SELECT DISTINCT Adotante.* from Contacto
INNER JOIN Adotante ON Adotante.Id = Contacto.Adotante_Id
LEFT JOIN doador ON Contacto.Número = doador.Número
WHERE doador.Número IS NOT NULL;	


-- INSERT INTO mydb.doador (id,email,nome,Número) VALUES("7","nuno@gmail.com","Nuno Rodrigues","927563128");

-- | Os doadores que mais donativos fizeram à associação
-- | Query10

SELECT  Doador.*,count(Donativo.id) AS `Total Doado` FROM Donativo
	INNER JOIN  Doador ON Donativo.Doador_Id = Doador.Id
    GROUP BY Doador.id
    ORDER BY `Total Doado` DESC;


DROP PROCEDURE IF EXISTS chegadaAnimal;
DELIMITER $$
CREATE PROCEDURE chegadaAnimal(
    IN a_id INT,
    IN a_Nome VARCHAR(40),
    IN a_Idade INT,
    IN a_Perfil VARCHAR(45),
    IN a_D_nascimento DATE,
    IN a_Registo_clinico TEXT,
    IN a_Categoria VARCHAR(20),
    IN a_Cor VARCHAR(20),
    IN a_Sexo CHAR(1),
    IN a_Raca VARCHAR(20),
    IN a_Peso INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O Animal existe no sistema' AS Resultado;
    END;

    START TRANSACTION;
    
    IF NOT EXISTS (SELECT 1 FROM animal WHERE Id = a_id) THEN
        INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
                 VALUES (a_id,a_nome,a_Idade,a_Perfil,a_D_nascimento ,a_Registo_clinico,a_Categoria,a_Cor,NULL,NULL,NOW(),a_Sexo,a_Raca,a_Peso ,NULL);
        SELECT 'Sucesso!' AS Resultado;
    ELSE
        ROLLBACK;
        SELECT 'Erro!' AS Resultado;
    END IF;
    
    COMMIT;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS PrimeiraAdoção;
DELIMITER $$
CREATE PROCEDURE PrimeiraAdoção(
    IN p_id INT,
    IN p_Nome VARCHAR(40),
    IN p_D_nascimento DATE,
    IN p_Sexo CHAR(1),
    IN p_N_Porta INT,
    IN p_Rua VARCHAR(40),
    IN p_CódigoPostal INT,
    IN p_Contacto INT,
    IN animal_adotado_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O adotante existe no sistema ou o ID do animal está incorreto' AS Resultado;
    END;

    START TRANSACTION;
    
    IF NOT EXISTS (SELECT 1 FROM Adotante WHERE Id = p_id) AND EXISTS (SELECT 1 FROM Animal WHERE id = animal_adotado_id AND D_adoção is NULL) THEN
    
        INSERT INTO mydb.adotante (Id, Nome, D_nascimento, Sexo, N_Porta, Rua, CódigoPostal)  VALUES (p_id, p_Nome, p_D_nascimento, p_Sexo, p_N_Porta, p_Rua, p_CódigoPostal);
        
        INSERT INTO mydb.Contacto (Adotante_id, Número) VALUES (p_id, p_Contacto);
        
        UPDATE Animal SET Animal.Adotante_Id = p_id, Animal.D_adoção = NOW() WHERE Animal.id = animal_adotado_id;
        
        SELECT 'Sucesso!' AS Resultado;
    ELSE

        ROLLBACK;
    END IF;
    
    COMMIT;
    SELECT 'Sucesso: Adoção foi realizada!' AS Resultado;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS PerfilDoador;
DELIMITER $$
CREATE PROCEDURE PerfilDoador(
    IN p_id INT,
    IN p_Email VARCHAR(40),
    IN p_Nome VARCHAR(40),
    IN p_num INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O Doador existe no sistema' AS Resultado;
    END;

    START TRANSACTION;
    
    IF NOT EXISTS (SELECT 1 FROM doador WHERE doador.Id = p_id) THEN
        INSERT INTO mydb.doador (Id, Email, Nome, Número) VALUES (p_id, p_Email, p_Nome, p_num);        
        SELECT 'Sucesso: Registro foi realizado!' AS Resultado;
    ELSE
        ROLLBACK;
        SELECT 'Erro: O Doador existe no sistema' AS Resultado;
    END IF;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS PerfilFuncionário;
DELIMITER $$
CREATE PROCEDURE PerfilFuncionário(
    IN f_id INT,
    IN f_Nome VARCHAR(45),
    IN f_Email VARCHAR(40),
    IN f_Estatuto VARCHAR(1),
    IN f_rua VARCHAR(45),
    IN f_N_Porta INT,
    IN f_CódigoPostal INT,
    IN f_Número INT,
    IN DispString VARCHAR(255),
    IN AptString VARCHAR(255)
)
BEGIN
    DECLARE weekdayValue VARCHAR(20);
    DECLARE AptValue VARCHAR(40);
    DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O Funcionário existe no sistema' AS Resultado;
    END;

    START TRANSACTION;
    
    IF NOT EXISTS (SELECT 1 FROM funcionário WHERE funcionário.Id = f_id) THEN
    
        INSERT INTO funcionário (Id, Nome, Email, Estatuto, Rua, N_Porta, CódigoPostal, Número) 
        VALUES (f_id, f_Nome, f_Email, f_Estatuto, f_rua, f_N_Porta, f_CódigoPostal, f_Número);
        
		-- Insert competências
        SET startIndex = 1;
        SET endIndex = LOCATE(',', AptString);
		
        WHILE endIndex > 0 DO
            SET AptValue = SUBSTRING(AptString, startIndex, endIndex - startIndex);
				
            -- Perform the insert operation for each aptidão
            INSERT INTO competência (aptidão,Funcionário_Id)
            VALUES (AptValue, f_id);

            -- Update the loop variables
            SET startIndex = endIndex + 1;
            SET endIndex = LOCATE(',', AptString, startIndex);
        END WHILE;

        -- Insert the last aptidão value
        SET AptValue = SUBSTRING(AptString, startIndex);
        INSERT INTO competência (aptidão,Funcionário_Id)
        VALUES (AptValue, f_id);

        -- Insert funcionário
        
        IF f_Estatuto = 'V' THEN
            -- Initialize the loop
            SET startIndex = 1;
            SET endIndex = LOCATE(',', DispString);
			SELECT startIndex, endIndex, AptValue;
            -- Loop through the weekday values
            WHILE endIndex > 0 DO
                SET weekdayValue = SUBSTRING(DispString, startIndex, endIndex - startIndex);

                -- Perform the insert operation for each weekday
                INSERT INTO disponibilidade (Funcionário_Id, DiaDaSemana) 
                VALUES (f_id, weekdayValue);

                -- Update the loop variables
                SET startIndex = endIndex + 1;
                SET endIndex = LOCATE(',', DispString, startIndex);
            END WHILE;

            -- Insert the last weekday value
            SET weekdayValue = SUBSTRING(DispString, startIndex);
            INSERT INTO disponibilidade (Funcionário_Id, DiaDaSemana) 
            VALUES (f_id, weekdayValue);
        END IF;

        SELECT 'Sucesso: Registro foi realizado!' AS Resultado;
    ELSE
        ROLLBACK;
        SELECT 'Erro: O Funcionário existe no sistema' AS Resultado;
    END IF;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS fazerDoaçãoBem;
DELIMITER $$
CREATE PROCEDURE fazerDoaçãoBem(
    IN p_id INT,
    IN d_id INT,
    IN d_validade DATE,
    IN d_quantidade DOUBLE,
    IN d_categoria  VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O Doador não existe no sistema ou o donativo não é válido' AS Resultado;
    END;

    START TRANSACTION;
    
    IF EXISTS (SELECT 1 FROM doador WHERE doador.Id = p_id) THEN
        INSERT INTO mydb.donativo (Id,Categoria,D_validade, Quantidade,Doador_Id) VALUES (d_id, d_categoria, d_validade, d_quantidade,p_id);        
        SELECT 'Sucesso: Doação foi realizada!' AS Resultado;
    ELSE
        ROLLBACK;
         SELECT 'Sucesso: Doação não foi realizada!' AS Resultado;
    END IF;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS fazerDoaçãoDinheiro;
DELIMITER $$
CREATE PROCEDURE fazerDoaçãoDinheiro(
    IN p_id INT,
    IN d_id INT,
    IN c_IBAN varchar(45),
    IN c_Operação varchar(45),
    IN c_Montante double,
    in c_NomeBanco varchar(60),
    in c_DataMovimento datetime
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O Doador não existe no sistema ou o donativo não é válido' AS Resultado;
    END;

    START TRANSACTION;
    
    IF EXISTS (SELECT 1 FROM doador WHERE doador.Id = p_id) THEN
        INSERT INTO mydb.donativo (Id,Categoria,D_validade, Quantidade,Doador_Id) VALUES (d_id,"Dinheiro", null, null,p_id);
        INSERT INTO mydb.comprovativo (IBAN,Operação,Montante, NomeBanco,Donativo_Id,DataMovimento) VALUES (c_IBAN,c_Operação,c_Montante, c_NomeBanco,d_id,c_DataMovimento);   
        
        SELECT 'Sucesso: Doação foi realizada!' AS Resultado;
    ELSE
        ROLLBACK;
         SELECT 'Sucesso: Doação não foi realizada!' AS Resultado;
    END IF;
    
    COMMIT;
END $$
DELIMITER ;



-- -------------------------------------------------------------------------------------------------------------------------
-- Jõao

-- | Os administradores devem conseguir visualizar o montante doado por cada doador caso a doação foi feita em dinheiro
-- | Query8
    Select doador.Nome, sum(Montante) as totalDoado FROM Comprovativo
        INNER JOIN donativo ON Comprovativo.donativo_id = donativo.id
		INNER JOIN  Doador ON donativo.doador_id = doador.id
        group by doador.nome;
        


DROP PROCEDURE IF EXISTS MaisQueUmaAdoção;
DELIMITER $$
CREATE PROCEDURE MaisQueUmaAdoção(
    IN p_id INT,
    IN animal_adotado_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O adotante não existe no sistema ou o ID do animal está incorreto' AS Resultado;
    END;

    START TRANSACTION;
    
    IF EXISTS (SELECT 1 FROM Adotante WHERE Id = p_id) AND EXISTS (SELECT 1 FROM Animal WHERE id = animal_adotado_id AND D_adoção is NULL) THEN
        
        UPDATE Animal SET Animal.Adotante_Id = p_id, Animal.D_adoção = NOW() WHERE Animal.id = animal_adotado_id;
        
        SELECT 'Sucesso!' AS Resultado;
    ELSE
       
        ROLLBACK;
    END IF;
    
    COMMIT;
    SELECT 'Sucesso: Adoção foi realizada!' AS Resultado;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS PrimeiraAdoção;
DELIMITER $$
CREATE PROCEDURE PrimeiraAdoção(
    IN p_id INT,
    IN p_Nome VARCHAR(40),
    IN p_D_nascimento DATE,
    IN p_Sexo CHAR(1),
    IN p_N_Porta INT,
    IN p_Rua VARCHAR(40),
    IN p_CódigoPostal INT,
    IN p_Contacto INT,
    IN animal_adotado_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: O adotante existe no sistema ou o ID do animal está incorreto' AS Resultado;
    END;

    START TRANSACTION;
    
    IF NOT EXISTS (SELECT 1 FROM Adotante WHERE Id = p_id) AND EXISTS (SELECT 1 FROM Animal WHERE id = animal_adotado_id AND D_adoção is NULL) THEN
    
        INSERT INTO mydb.adotante (Id, Nome, D_nascimento, Sexo, N_Porta, Rua, CódigoPostal)  VALUES (p_id, p_Nome, p_D_nascimento, p_Sexo, p_N_Porta, p_Rua, p_CódigoPostal);
        
        INSERT INTO mydb.Contacto (Adotante_id, Número) VALUES (p_id, p_Contacto);
        
        UPDATE Animal SET Animal.Adotante_Id = p_id, Animal.D_adoção = NOW() WHERE Animal.id = animal_adotado_id;
        
        SELECT 'Sucesso!' AS Resultado;
    ELSE

        ROLLBACK;
    END IF;
    
    COMMIT;
    SELECT 'Sucesso: Adoção foi realizada!' AS Resultado;
END $$
DELIMITER ;



CREATE VIEW FuncionarioCompetenciasDisponiblidade AS
SELECT funcionário.Nome, GROUP_CONCAT(DISTINCT Competência.Aptidão) AS comp_combinadas, GROUP_CONCAT(DISTINCT disponibilidade.DiaDaSemana) AS Disp_combinadas
FROM mydb.funcionário
INNER JOIN mydb.Competência ON Funcionário.Id = Competência.Funcionário_Id
INNER JOIN mydb.disponibilidade ON Funcionário.Id = disponibilidade.Funcionário_Id
GROUP BY mydb.funcionário.Nome;



CREATE VIEW DoadorEmDinheiro AS
SELECT comprovativo.IBAN,comprovativo.Operação,comprovativo.Montante,comprovativo.NomeBanco,comprovativo.DataMovimento,Doador.Nome from Comprovativo
INNER JOIN mydb.donativo ON comprovativo.Donativo_Id = Donativo.Id
INNER JOIN mydb.doador ON Donativo.Doador_Id = doador.id;


CREATE VIEW AdotanteContactos AS
SELECT adotante.*,GROUP_CONCAT(DISTINCT contacto.Número) AS Contactos from adotante
INNER JOIN mydb.contacto ON adotante.Id = contacto.Adotante_Id
GROUP BY adotante.id;


-- -------------------------------------------------------------------------------------------------------------------------
-- Rodrigo

DELIMITER $$
CREATE PROCEDURE FuncionárioAcedeDonativo(IN id_Funcionário INT, IN id_Donativo INT, IN quantidadeUsada DOUBLE )
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: Algum Id está incorreto' AS Resultado;
    END;
     START TRANSACTION;
    IF EXISTS (SELECT 1 FROM Funcionário WHERE Id = id_Funcionário) AND  EXISTS (SELECT 1 FROM Donativo WHERE Id = id_Donativo)  AND quantidadeUsada >= 0 THEN

		INSERT INTO mydb.TB_FuncionárioDonativo(D_acesso,Donativo_Id,Funcionário_ID) VALUES(NOW(),id_Donativo,id_Funcionário);
		call consumo_donativo(id_Donativo,quantidadeUsada);
        SELECT 'Sucesso!' AS Resultado;
    ELSE
    ROLLBACK;
    END IF;
    COMMIT;
    SELECT 'Sucesso!' AS Resultado;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE FuncionárioTrataAnimal(IN id_Funcionário INT, IN id_Animal INT)
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: Algum Id está incorreto' AS Resultado;
    END;
    START TRANSACTION;
    IF EXISTS (SELECT 1 FROM Funcionário WHERE Id = id_Funcionário) AND  EXISTS (SELECT 1 FROM Animal WHERE Id = id_Animal) THEN

		INSERT INTO mydb.tb_animalfuncionário(D_tratamento,Animal_Id,Funcionário_ID) VALUES(NOW(),id_Animal,id_Funcionário);
        SELECT 'Sucesso!' AS Resultado;
    ELSE
    ROLLBACK;
    END IF;
    COMMIT;
    SELECT 'Sucesso!' AS Resultado;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE FuncionárioUsaDonativoEmAnimal(IN id_Funcionário INT, IN id_Animal INT,IN id_Donativo INT,in quantidadeUsada DOUBLE)
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: Algum Id está incorreto' AS Resultado;
    END;
    START TRANSACTION;
    IF EXISTS (SELECT 1 FROM Funcionário WHERE Id = id_Funcionário) AND  EXISTS (SELECT 1 FROM Donativo WHERE Id = id_Donativo) AND  EXISTS (SELECT 1 FROM Animal WHERE Id = id_Animal)  AND quantidadeUsada >= 0 THEN

		INSERT INTO mydb.TB_FuncionárioDonativo(D_acesso,Donativo_Id,Funcionário_ID) VALUES(NOW(),id_Donativo,id_Funcionário);
        INSERT INTO mydb.tb_animalfuncionário(D_tratamento,Animal_Id,Funcionário_ID) VALUES(NOW(),id_Animal,id_Funcionário);
		call consumo_donativo(id_Donativo,quantidadeUsada);
        SELECT 'Sucesso!' AS Resultado;
    ELSE
    ROLLBACK;
    END IF;
    COMMIT;
    SELECT 'Sucesso: Operação foi realizada!' AS Resultado;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS adicionar_contacto;
DELIMITER $$
CREATE PROCEDURE adicionar_contacto (IN id_Adotante INT, IN num INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro: Algum Id está incorreto' AS Resultado;
    END;
    START TRANSACTION;
    
    IF EXISTS (SELECT 1 FROM adotante WHERE adotante.Id = id_Adotante) AND NOT EXISTS (SELECT 1 FROM contacto WHERE contacto.Número = num) THEN
        INSERT INTO mydb.contacto (Número, Adotante_Id) VALUES (num, id_Adotante);
        SELECT 'Sucesso: Operação foi realizada!' AS Resultado;
    ELSE
        ROLLBACK;
        SELECT 'Erro: Algum Id está incorreto ou Número já existente' AS Resultado;
    END IF;
    
    COMMIT;
END $$
DELIMITER ;


/*
DELIMITER $$
CREATE PROCEDURE SelecionarDonativosUsadosPorIDAnimal(IN id_Animal INT)
BEGIN
    SELECT DISTINCT fd.Donativo_Id
    FROM TB_AnimalFuncionário af
    INNER JOIN TB_FuncionárioDonativo fd ON af.Funcionário_Id = fd.Funcionário_Id
    WHERE af.Animal_id = id_Animal
       AND fd.D_acesso = af.D_tratamento;
END $$
DELIMITER ;
*/
