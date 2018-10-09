#!C:/Python27/python
print ("Content-Type: text/html")
print("")
import cgi 
import MySQLdb
import datetime

form=cgi.FieldStorage()

#idCliente = form.getvalue("idCliente")
nombre = form.getvalue("nombre")
dni = form.getvalue("dni") 
cumple  = form.getvalue("cumple")
#format_str=%d%m%Y
#cumple = datetime.date.strptime(cumple,format_str)
localidad = form.getvalue("localidad")
email = form.getvalue("email")

#host=, user=, password=, database=
con=MySQLdb.connect('localhost', 'root', '', 'hotel')

cur=con.cursor()
cur.execute("INSERT INTO clientes ( nombre, dni, cumple, localidad, email) VALUES (%s, %s, %s, %s, %s)", (nombre, dni, cumple, localidad, email))
#cur.execute("insert into clientes values(%s, %s, %s, %s, %s)", (nombre, dni, cumple, localidad, email))

con.commit()

cur.close()
con.close()
print("<h1>Record Inserted Sucessfully</h1>")
