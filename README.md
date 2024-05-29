API for Inserting Data from CSV File to PostgreSQL Database
This API allows receiving a CSV file and loading its data into a specific table in a PostgreSQL database.

1.Installation
Clone this repository:
git clone https://github.com/BrianCarabantes/BC_year2024.git

2.Install the necessary dependencies:
pip install Flask psycopg2

3.Configuration of the database:
Make sure you have a PostgreSQL server running.
Modify the DB_HOST, DB_NAME, DB_USER, and DB_PASSWORD variables in the ejercicio1_2024.py file with the corresponding information for your database.
Run python ejercicio1_2024.py

4.Usage to sending a CSV File:
Send a POST request to the /upload endpoint with the CSV file containing the data to insert and the name of the table in the database.

Contributing
Contributions are welcome! If you'd like to contribute to this project, follow these steps:

Fork the repository.
Create a new branch (git checkout -b feature/your-new-feature).
Make your changes.
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature/your-new-feature).
Create a new Pull Request.

License
This project is licensed under the MIT License.

