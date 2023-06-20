
CREATE USER 'duarte1'@'localhost' IDENTIFIED BY 'du1';
GRANT EXECUTE ON PROCEDURE consumo_donativo TO 'duarte1'@'localhost' ;
GRANT EXECUTE ON PROCEDURE adicionar_contacto TO 'duarte1'@'localhost';
GRANT EXECUTE ON PROCEDURE FuncionárioAcedeDonativo TO 'duarte1'@'localhost';
GRANT EXECUTE ON PROCEDURE FuncionárioTrataAnimal TO 'duarte1'@'localhost';
GRANT EXECUTE ON PROCEDURE FuncionárioUsaDonativoEmAnimal TO 'duarte1'@'localhost';

CREATE USER 'voluntario2'@'localhost' IDENTIFIED BY 'vol2';
GRANT EXECUTE ON PROCEDURE consumo_donativo TO 'voluntario2'@'localhost';
GRANT EXECUTE ON PROCEDURE adicionar_contacto TO 'voluntario2'@'localhost';
GRANT EXECUTE ON PROCEDURE FuncionárioAcedeDonativo TO 'voluntario2'@'localhost';
GRANT EXECUTE ON PROCEDURE FuncionárioTrataAnimal TO 'voluntario2'@'localhost';
GRANT EXECUTE ON PROCEDURE FuncionárioUsaDonativoEmAnimal TO 'voluntario2'@'localhost';



CREATE USER 'rodrigo'@'localhost' IDENTIFIED BY 'rod123';
GRANT ALL PRIVILEGES ON *.* TO  'rodrigo'@'localhost';

CREATE USER 'joao'@'localhost' IDENTIFIED BY 'joao123';
GRANT ALL PRIVILEGES ON *.* TO  'joao'@'localhost' ;


DROP USER 'duarte1'@'localhost';
DROP USER 'voluntario2'@'localhost';
DROP USER 'rodrigo'@'localhost';
DROP USER 'joao'@'localhost';