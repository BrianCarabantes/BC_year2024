#Brian Carabantes
#Ejercicio 1
#Version environment created (venv)

import flask
import csv
import psycopg2

app = flask.Flask(__name__)  #flask instance

#Database connection 
DB_HOST = 'localhost'
DB_NAME = 'testing_2024'
DB_USER = 'postgres'
DB_PASSWORD = '123456'
connection = psycopg2.connect(host=DB_HOST, database=DB_NAME, user=DB_USER, password=DB_PASSWORD)
cursor = connection.cursor()

#Endpoint to receive CSV file and insert data into database
@app.route('/upload', methods=['POST'])
def upload_csv():
    try:
        #Get table name from request
        table_name = flask.request.form.get('table_name')
        #Get CSV file from request
        csv_file = flask.request.files['file']
        #Read CSV file and insert data into database
        if csv_file and table_name:
            csv_data = csv.reader(csv_file)
            next(csv_data)  #Skip the first row, because they are headers
            batch_size = 1000
            batch_data = []
            for row in csv_data:
                batch_data.append(row)
                #Insert batch data into database
                if len(batch_data) >= batch_size:
                    insert_batch_data(table_name, batch_data)
                    batch_data = []
            #Insert any remaining data
            if batch_data:
                insert_batch_data(table_name, batch_data)
            connection.commit()
            return flask.jsonify({'message': 'The Data was inserted successfully'}), 200  #Successfull
        else:
            return flask.jsonify({'error': 'Missing file or table_name parameter'}), 400  #Not successfull
    except Exception as e:
        connection.rollback()
        return flask.jsonify({'error': str(e)}), 500

#Create a function to insert batch data into database
def insert_batch_data(table_name, data):
    placeholders = ','.join(['%s'] * len(data[0])) 
    insert_query = f"INSERT INTO {table_name} VALUES ({placeholders})"
    cursor.executemany(insert_query, data) #Method

if __name__ == '__main__':  #File name
    app.run(debug=True)     #Detailed messages in case of errors and it will automatically restart if it detects changes in the source code
