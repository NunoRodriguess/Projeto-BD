-- | 8:00 Alimentar os Animais
    select * from Funcionário;
    select * from Donativo;
    select * from Animal;
    call FuncionárioUsaDonativoEmAnimal(1,1,1,0.05);
    call FuncionárioUsaDonativoEmAnimal(1,5,2,0.02);
    call FuncionárioUsaDonativoEmAnimal(1,6,2,0.02);
    call FuncionárioUsaDonativoEmAnimal(1,7,2,0.03);
    call FuncionárioUsaDonativoEmAnimal(1,8,4,0.06);

-- | 9:12 Chegada de um novo animal

    call chegadaAnimal(9,"Pipo",2,"Dócil","2021-01-10","Vacinado"
        ,"Canideo","Branco","M","Pitbull",14);

    call FuncionárioTrataAnimal(2,9);
    call FuncionárioUsaDonativoEmAnimal(1,9,4,0);


-- | 13:10 Doação realizada
    select  * from Doador;
    call PerfilDoador(7,"jota@gmail.com","João Borges",961098123);
    call fazerDoaçãoBem(7,12,"2023-06-20",1,"Comida de Cão");



-- | 16:53 Adoção
    call PrimeiraAdoção(3,"Roberto Carlos","1982-10-12","M","7",
        "Rua dos Peões","4710190",911489009,8);

-- | 20:00 Alimentar os Animais

    call FuncionárioUsaDonativoEmAnimal(3,1,1,0.05);
    call FuncionárioUsaDonativoEmAnimal(3,5,2,0.02);
    call FuncionárioUsaDonativoEmAnimal(3,6,2,0.02);
    call FuncionárioUsaDonativoEmAnimal(4,7,2,0.03);
    call FuncionárioUsaDonativoEmAnimal(4,9,1,0.04);
