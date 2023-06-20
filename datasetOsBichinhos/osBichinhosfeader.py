import csv
import mysql.connector

# MySQL database configuration
config = {
    'user': 'root',
    'password': 'nunonuno153',
    'host': 'localhost',
    'database': 'mydb',
    'raise_on_warnings': True
}

# CSV file path
csv_file_pathAnimal = 'datasetOsBichinhos/animal.csv'
csv_file_pathDoador = 'datasetOsBichinhos/doador.csv'
csv_file_pathDonativo = 'datasetOsBichinhos/donativo.csv'
csv_file_pathAdocao = 'datasetOsBichinhos/adocao.csv'
csv_file_pathContacto = 'datasetOsBichinhos/contacto.csv'
csv_file_pathDisponibilidade = 'datasetOsBichinhos/disponibilidade.csv'
csv_file_pathComprovativo = 'datasetOsBichinhos/comprovativo.csv'
csv_file_pathFuncionario = 'datasetOsBichinhos/funcionario.csv'
csv_file_pathCompetencias = 'datasetOsBichinhos/competencias.csv'


def importDataAnimal(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathAnimal, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Check for empty values and replace them with NULL
            row = [value if value else None for value in row]

            # Adjust the column indexes as per your CSV file structure
            id = row[0]
            Nome = row[1]
            Idade = row[2]
            Perfil = row[3]
            D_nascimento = row[4]
            Registo_clinico = row[5]
            Categoria = row[6]
            Cor = row[7]
            D_adoção = row[8]
            D_saida = row[9]
            D_chegada = row[10]
            Sexo = row[11]
            Raça_espécie = row[12]
            Peso = row[13]
            Adotante_Id = row[14]

            # Insert data into the database
            insert_query = """
                INSERT INTO Animal (
                    id, Nome, Idade, Perfil, D_nascimento, Registo_clinico,
                    Categoria, Cor, D_adoção, D_saida, D_chegada, Sexo,
                    `Raça e espécie`, Peso, Adotante_Id
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                id, Nome, Idade, Perfil, D_nascimento, Registo_clinico,
                Categoria, Cor, D_adoção, D_saida, D_chegada, Sexo,
                Raça_espécie, Peso, Adotante_Id
            )
            cursor.execute(insert_query, values)


def importDataDoador(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathDoador, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Check for empty values and replace them with NULL
            row = [value if value else None for value in row]

            # Adjust the column indexes as per your CSV file structure
            id = row[0]
            Email = row[1]
            Nome = row[2]
            Número = row[3]

            # Insert data into the database
            insert_query = """
                INSERT INTO Doador (
                    id, Email, Nome, Número
                )
                VALUES (%s, %s, %s, %s)
            """
            values = (
                id, Email, Nome, Número
            )
            cursor.execute(insert_query, values)


def importDataDonativo(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathDonativo, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Adjust the column indexes as per your CSV file structure
            row = [value if value else None for value in row]
            Id = row[0]
            Categoria = row[1]
            D_validade = row[2]
            Quantidade = row[3]
            Doador_Id = row[4]

            # Insert data into the database
            insert_query = """
                INSERT INTO Donativo (
                    Id, Categoria, D_validade, Quantidade, Doador_Id
                )
                VALUES (%s, %s, %s, %s, %s)
            """
            values = (
                Id, Categoria, D_validade, Quantidade, Doador_Id
            )
            cursor.execute(insert_query, values)


def importDataAdocao(cursor):
    # Read data from CSV and determine the number of rows
    with open(csv_file_pathAdocao, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            row_count = len(row)
            if row_count == 2:
                # Invoke Procedure 1
                procedure_name = 'MaisQueUmaAdoção'
            # Unpack the rows as arguments for Procedure 1
                args = (row[0], row[1])

            # Call Procedure 1
                cursor.callproc(procedure_name, args)

            elif row_count == 9:
                # Invoke Procedure 2
                procedure_name = 'PrimeiraAdoção'
                args = (row[0], row[1], row[2], row[3], row[4],
                        row[5], row[6], row[7], row[8])  # Unpack the rows as arguments for Procedure 2

            # Call Procedure 2
            cursor.callproc(procedure_name, args)


def importDataFuncionarios(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathFuncionario, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Adjust the column indexes as per your CSV file structure
            row = [value if value else None for value in row]
            Id = row[0]
            Nome = row[1]
            Email = row[2]
            Estatuto = row[3]
            Rua = row[4]
            N_Porta = row[5]
            CódigoPostal = row[6]
            Número = row[7]

            # Insert data into the database
            insert_query = """
                INSERT INTO Funcionário (
                    Id, Nome, Email, Estatuto, Rua, N_Porta, CódigoPostal, Número
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                Id, Nome, Email, Estatuto, Rua, N_Porta, CódigoPostal, Número
            )
            cursor.execute(insert_query, values)


def importDataContacto(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathContacto, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Adjust the column indexes as per your CSV file structure

            Número = row[0]
            Adotante_Id = row[1]

            # Insert data into the database
            insert_query = """
                INSERT INTO Contacto (
                    Número, Adotante_Id
                )
                VALUES (%s, %s)
            """
            values = (
                Número, Adotante_Id
            )
            cursor.execute(insert_query, values)


def importDataCompetencias(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathCompetencias, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Adjust the column indexes as per your CSV file structure

            Funcionário_Id = row[0]
            Aptidão = row[1]

            # Insert data into the database
            insert_query = """
                INSERT INTO Competência (
                    Funcionário_Id, Aptidão
                )
                VALUES (%s, %s)
            """
            values = (
                Funcionário_Id, Aptidão
            )
            cursor.execute(insert_query, values)


def importDataDisponiblidade(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathDisponibilidade, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Adjust the column indexes as per your CSV file structure

            Funcionário_Id = row[0]
            DiaDaSemana = row[1]

            # Insert data into the database
            insert_query = """
                INSERT INTO Disponibilidade (
                    Funcionário_Id, DiaDaSemana
                )
                VALUES (%s, %s)
            """
            values = (
                Funcionário_Id, DiaDaSemana
            )
            cursor.execute(insert_query, values)


def importDataComprovativo(cursor):
    # Read data from CSV and insert into the database
    with open(csv_file_pathComprovativo, 'r') as file:
        reader = csv.reader(file)

        for row in reader:
            # Adjust the column indexes as per your CSV file structure
            iban = row[0]
            Operação = row[1]
            Montante = row[2]
            NomeBanco = row[3]
            Donativo_Id = row[4]
            DataMovimento = row[5]

            # Insert data into the database
            insert_query = """
                INSERT INTO Comprovativo (
                    IBAN, Operação, Montante, NomeBanco, Donativo_Id, DataMovimento
                )
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            values = (
                iban, Operação, Montante, NomeBanco, Donativo_Id, DataMovimento
            )
            cursor.execute(insert_query, values)


try:
    # Connect to the database
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
 
    # Import data from CSV
    importDataAnimal(cursor)
    importDataDoador(cursor)
    importDataDonativo(cursor)
    importDataComprovativo(cursor)
    importDataFuncionarios(cursor)
    importDataDisponiblidade(cursor)
    importDataCompetencias(cursor)
    importDataAdocao(cursor)
    # Commit the changes and close the connection
    connection.commit()
    cursor.close()
    connection.close()
    print('Data import completed.')

except mysql.connector.Error as error:
    print(f'Error: {error}')
