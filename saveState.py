import subprocess
import datetime

host = 'localhost'
port = 3306
username = 'root'
password = 'nunonuno153'
database = 'mydb'

current_datetime = datetime.now().strftime('%Y%m%d_%H%M%S')
backup_file = f'backup_{current_datetime}.sql'


subprocess.run(['mysqldump', '-h', host, '-P', str(port), '-u', username,
                '-p' + password, database, '--result-file=' + backup_file])
