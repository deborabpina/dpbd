# coding=UTF-8
import subprocess

#fdpre e oedgecfdsolver, sendo necessário replicá-la em todos os nos.
#No 1: dl_mat1, oedgecfdpre1, dl_mat3, oedgecfdpre3, osetsolverconfig1, dlin
#No 2: dl_mat2, oedgecfdpre2, dl_mat4, oedgecfdpre4, osetsolverconfig1, dlin
#No 3: dl_solver1, oedgecfdsolver1, osetsolverconfig1
#No 4: dl_solver2, oedgecfdsolver2, osetsolverconfig1, osetsolverconfig2
#No 5: demais tabelas


def create_DB(no,replication,frag_path):
	'''
	create DB with no_id no.
	SQL scripts for table creation in bd
	'''
	
	script = get_table_frag_script(no,replication)
	if(script!="null"):		
		subprocess.call("createdb -O postgres -T DPBD db"+str(no),shell=True)
		print("[+]:filling BD")
		print("[+]:psql -f "+script)
		subprocess.call("psql  -f "+frag_path+script+" -d "+"db"+str(no),shell=True)

def create_DBs(list_id_bd,replication,frag_path):
	'''
	create the sites where each site represent a database. 
	list_id_bd =[1,2,3,4]
	'''
	for i in list_id_bd:
		print("[+]:creating DB "+str(i))
		create_DB(i,replication,frag_path)


def get_table_script(no,replication):

	if (no==1): 
		return  "sitio1.sql" if(replication==True) else "sitio1-sem-replicacao.sql"
	elif (no==2):
	 	return  "sitio2.sql" if(replication==True)else "sitio2-sem-replicacao.sql"
	elif (no==3):
	 	return  "sitio3.sql" if(replication==True)else "sitio3-sem-replicacao.sql"
	elif(no==4): 
		return  "sitio4.sql" if(replication==True)else "sitio4-sem-replicacao.sql"

def get_table_frag_script(node, replication):
	'''
	Creates databases whith the fragmented tables
	'''
	if(replication==True):
		if(node==1):
			return "sitio1r.sql" 
		if(node==2):
			return "sitio2r.sql"
		if(node==3):
			return "sitio3r.sql"
		if(node==4):
			return "sitio4r.sql"
	else:
		if(node==1):
			return "sitio1sr.sql" 
		if(node==2):
			return "sitio2sr.sql"
		if(node>2):
			return "null"
		



def run_queries(list_query_files_name):
	'''
	Run queries based on  the .sql files found in queries/
	NOT WORKING: TELLING THAT bd don't exist

	'''
	for query_file in list_query_files_name:
		ide = query_file.split("_")[2].split(".")[0]
		print(ide)
		print("psql -d bd" + str(ide) + " -f "+query_file + " > " + query_file+".txt")
		subprocess.call("psql  -d bd" + str(ide) + " -f "+query_file + " > " + query_file+".txt",shell=True)
		

query_path = "/home/jean/SQL\ projects/DPBD/queries/"
frag_path = "/home/jean/SQL\ projects/DPBD/SQL\ Frag\ Tables/"
replication = False
list_id_bd=[1,2,3,4]
list_query_files_name=["query_2_2.sql","query_5_1.sql","query_5_2.sql","query_8_1.sql","query_8_2.sql","query_5_1_rep.sql","query_5_2_rep.sql","query_8_1_rep.sql","query_8_2_rep.sql"]
print("[+]:Creating DB")
create_DBs(list_id_bd,replication, frag_path)
print("[+]:DB created")
print("[+]:Running queries")
run_queries(list_query_files_name)