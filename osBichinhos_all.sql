-- Adotante: inserção de 6 adotantes

INSERT INTO mydb.adotante (id,Nome,D_nascimento,Sexo,N_Porta,Rua,CódigoPostal) VALUES ("1","Nuno Rodrigues","2003-10-16","M","7","Rua dos Peôes","4710416");
INSERT INTO mydb.adotante (id,Nome,D_nascimento,Sexo,N_Porta,Rua,CódigoPostal) VALUES ("2","Tomás Pacheco","2003-2-13","M","7","Rua dos Peôes","4710416");
INSERT INTO mydb.adotante (id,Nome,D_nascimento,Sexo,N_Porta,Rua,CódigoPostal) VALUES ("3","Martim Manhã","1999-4-20","M","101","Rua de São Marcos","4700409");
INSERT INTO mydb.adotante (id,Nome,D_nascimento,Sexo,N_Porta,Rua,CódigoPostal) VALUES ("4","Donatella Versace","1955-5-2","F","20","Rua Nova de Santa Cruz","4710409 ");
INSERT INTO mydb.adotante (id,Nome,D_nascimento,Sexo,N_Porta,Rua,CódigoPostal) VALUES ("5","Bella Hadid","1996-10-9","F","123","Rua dos Chãos","4700235");
INSERT INTO mydb.adotante (id,Nome,D_nascimento,Sexo,N_Porta,Rua,CódigoPostal) VALUES ("6","Kendall Jenner","1995-11-3","F","456","Avenida Central","4710228");
INSERT INTO mydb.adotante (id,Nome,D_nascimento,Sexo,N_Porta,Rua,CódigoPostal) VALUES ("7","Nelo Chapeiro","1995-11-3","M","456","Avenida Central","4710228");

-- Contactos: inserção de 7 Contactos
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(1,910000212);
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(1,253334531);
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(2,966111424);
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(3,966197129);
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(4,911341821);
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(5,923232312);
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(6,961166890);
INSERT INTO mydb.contacto(Adotante_id,Número) VALUES(7,961531089);

-- Doadores: inserção de 6 doadores

INSERT INTO mydb.doador (id,email,nome,Número) VALUES("1","renatomartins@gmail.com","Renato Martins","984123089");
INSERT INTO mydb.doador (id,email,nome,Número) VALUES("2","diogoPaiva@gmail.com","Diogo Paiva","921125089");
INSERT INTO mydb.doador (id,email,nome,Número) VALUES("3","RodrigoGomes@gmail.com","Rodrigo Gomes","924143059");
INSERT INTO mydb.doador (id,email,nome,Número) VALUES("4","jeff@gmail.com","Jeffrey Bezos","966123089");
INSERT INTO mydb.doador (id,email,nome,Número) VALUES("5","antonioM3des@gmail.com","António Mendes","911123089");
INSERT INTO mydb.doador (id,email,nome,Número) VALUES("6","nelo@gmail.com","Nelo Chapeiro","961531089");


-- Donativo: inserção de 10 Donativos

INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("1","Comida para Cão","2023-5-30","1.0","1");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("2","Comida para Gato","2023-5-30","2.0","1");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("3","Comida para Pássaro","2023-7-11","1.0","2");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("4","Comida para Coelho","2023-8-05","1.0","2");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("5","Mantas",NULL,"1.0","3");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("6","Mantas",NULL,"1.0","3");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("7","Mantas",NULL,"1.0","3");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("8","Cama",NULL,"1.0","6");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("9","Brinquedo",NULL,"1.0","5");
INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("10","Dinheiro",NULL,NULL,"4");


INSERT INTO mydb.donativo(id,Categoria,D_validade,Quantidade,Doador_Id)VALUES("11","Dinheiro","2023-1-11","1.0","2");

-- Comprovativo: inserção de 1 Comprovativo
INSERT INTO mydb.comprovativo(IBAN,Operação,Montante,NomeBanco,DataMovimento,Donativo_id) VALUES ("PT00000000000000000000000000000001","Transferência","10000000","SANTANDER TOTTA","2023-2-2","10");

-- Animais: inserção de 8 Animais

INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("1",NULL,NULL,"Agressivo",NULL,NULL,"Canídeo","Preto e Castanho",NULL,NULL,"2023-4-10","M","Arraçado Boxer","29",NULL);
INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("2","Pantufa",5,"Dócil","2018-1-10","Vacinado e Castrado","Canídeo","Castanho",NULL,NULL,"2023-4-15","M","Chow Chow","27",NULL);
INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("3","Lua",4,"Dócil","2019-3-22","Vacinado e Castrado","Canídeo","Branco",NULL,NULL,"2023-4-12","F","Arraçado Samoyed","17",NULL);
INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("4","Balu",2,"Dócil","2020-8-11","Vacinado","Canídeo","Castanho",NULL,NULL,"2023-3-30","M","Bulldog","25",NULL);
INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("5","Coco",5,"Dócil","2018-2-10","Vacinado e Castrado","Felino","Branco",NULL,NULL,"2023-4-5","F","Ragdoll","8",NULL);
INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("6","Mia",6,"Dócil","2017-1-22","Vacinado","Felino","Laranja",NULL,NULL,"2023-4-12","F","Persian","5",NULL);
INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("7","Ozzy",NULL,"Agressivo",NULL,"Vacinado","Felino","Preto",NULL,NULL,"2023-3-29","M","Arraçado Bombay","4",NULL);
INSERT INTO mydb.animal(id,Nome,Idade,Perfil,D_nascimento,Registo_Clinico,Categoria,Cor,D_adoção,D_saida,D_chegada,Sexo,`Raça e espécie`,Peso,Adotante_Id)
			     VALUES ("8","Lizzy",NULL,"Dócil",NULL,"Teste às Bactérias","Iguanids","Verde",NULL,NULL,"2023-4-25","M","Iguana-Verde","4",NULL);



-- Funcionários:inserção de 4 Funcionários
INSERT INTO mydb.funcionário(Id,Nome,Email,Estatuto,CódigoPostal,Rua,N_Porta,Número)VALUES("1","Rodrigo Gomes","rodgm@gmail.com","P","4716221","Avenida Lateral","10","910389123");
INSERT INTO mydb.funcionário(Id,Nome,Email,Estatuto,CódigoPostal,Rua,N_Porta,Número)VALUES("2","João Magalhães","jmag@gmail.com","P","4800275","Rua 15 de Maio","223","966375141");
INSERT INTO mydb.funcionário(Id,Nome,Email,Estatuto,CódigoPostal,Rua,N_Porta,Número)VALUES("3","Raquel Silva","rqsil@gmail.com","V","4705791","Rua da Capela de Baixo","111","926169626");
INSERT INTO mydb.funcionário(Id,Nome,Email,Estatuto,CódigoPostal,Rua,N_Porta,Número)VALUES("4","Duarte Antunes","dant12@gmail.com","V","4710077","Rua da Igreja Nova","84","911122153");

INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("1","Segunda-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("1","Terça-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("1","Quarta-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("1","Quinta-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("1","Sexta-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("1","Sábado");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("1","Domingo");

INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("2","Segunda-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("2","Terça-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("2","Quarta-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("2","Quinta-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("2","Sexta-feira");
INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("3","Segunda-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("3","Terça-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("3","Quarta-feira");
INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("4","Quinta-feira");INSERT INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES ("4","Sexta-feira");


-- Comprovativo: inserção de 1 Competências

INSERT INTO mydb.competência(aptidão,funcionário_id) VALUES ("Veterinário","1");
INSERT INTO mydb.competência(aptidão,funcionário_id) VALUES ("Tratador","1");
INSERT INTO mydb.competência(aptidão,funcionário_id) VALUES ("Enfermeiro","2");
INSERT INTO mydb.competência(aptidão,funcionário_id) VALUES ("Secretário","2");
INSERT INTO mydb.competência(aptidão,funcionário_id) VALUES ("Tratador","2");
INSERT INTO mydb.competência(aptidão,funcionário_id) VALUES ("Tratador","3");
INSERT INTO mydb.competência(aptidão,funcionário_id) VALUES ("Tratador","4");
 
SELECT * FROM Disponibilidade;
