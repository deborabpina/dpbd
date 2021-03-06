# coding=UTF-8
import subprocess

#fdpre e oedgecfdsolver, sendo necessário replicá-la em todos os nos.
#No 1: dl_mat1, oedgecfdpre1, dl_mat3, oedgecfdpre3, osetsolverconfig1, dlin
#No 2: dl_mat2, oedgecfdpre2, dl_mat4, oedgecfdpre4, osetsolverconfig1, dlin
#No 3: dl_solver1, oedgecfdsolver1, osetsolverconfig1
#No 4: dl_solver2, oedgecfdsolver2, osetsolverconfig1, osetsolverconfig2
#No 5: demais tabelas


def create_DB(no,replication,frag_path,db_template):
	'''
	create DB with no_id no.
	SQL scripts for table creation in bd
	'''
	
	script = get_table_frag_script(no,replication)
	if(script!="null"):		
		print("[+]:filling BD")
		print("[+]:psql -f "+script)
		if(replication==False):
			db="db"
			subprocess.call("createdb -O postgres -T "+db_template+" "+db+str(no),shell=True)
			subprocess.call('psql -d '+db+str(no)+' -c "CREATE EXTENSION dblink"',shell=True)
			subprocess.call("psql  -f "+frag_path+script+" -d "+"db"+str(no),shell=True)
		else:
			db="db_rep"
			subprocess.call("createdb -O postgres -T "+db_template+ " "+db+str(no),shell=True)
			subprocess.call('psql -d '+db+str(no)+' -c "CREATE EXTENSION dblink"',shell=True)
			subprocess.call("psql  -f "+frag_path+script+" -d "+"db_rep"+str(no),shell=True)


def create_DBs(list_id_bd,frag_path,db_template):
	'''
	create the sites where each site represent a database. 
	list_id_bd =[1,2,3,4]
	'''
	for i in list_id_bd:
		print("[+]:creating DB "+str(i))
		create_DB(i,True,frag_path,db_template)
		create_DB(i,False,frag_path,db_template)


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
		



def run_queries(list_query_files_name, list_query_files_name_rep):
	'''
	Run queries based on  the .sql files found in queries/
	NOT WORKING: TELLING THAT bd don't exist

	'''
	for query_file in list_query_files_name:
		ide = query_file.split("_")[2].split(".")[0]			
		print("[+]:psql -d bd" + str(ide) + " -f "+query_path+query_file + " > " + query_file+".txt")
		subprocess.call("psql  -d db" + str(ide) + " -f "+query_path+query_file + " -o " + query_file+".txt",shell=True)
	for query_file in list_query_files_name_rep:
		ide = query_file.split("_")[2]			
		print("[+]:psql -d bd_rep" + str(ide) + " -f "+query_path+query_file + " > " + query_file+".txt")
		subprocess.call("psql  -d db_rep" + str(ide) + " -f "+query_path+query_file + " -o " + query_file+".txt",shell=True)

def run_final_queries(final_queries):
	for query_file in final_queries:
		ide = query_file.split("_")[2]
		subprocess.call("psql  -d db_rep" + str(ide) + " -f "+query_path+query_file + " -o " + query_file+".txt",shell=True)

		
db_template = "DPBD"
query_path = "/home/jean/SQL\ projects/DPBD/queries/"
frag_path = "/home/jean/SQL\ projects/DPBD/SQL\ Frag\ Tables/"
replication = False
list_id_bd=[1,2,3,4]
list_query_files_name=["query_2_2.sql","query_5_1.sql","query_8_1.sql","query_8_2.sql"] #query removida "query_5_2.sql"
list_query_files_name_rep = ["query_5_1_rep.sql","query_5_2_rep.sql","query_8_1_rep.sql","query_8_2_rep.sql"] # not used
final_queries= ["query_2_2_final.sql","query_5_1_final.sql" ,"query_8_1_final.sql","query_5_1_final_rep.sql","query_8_1_final_rep.sql"]
print("[+]:Creating DB")
#create_DBs(list_id_bd, frag_path,db_template)
print("[+]:DB created")
print("[+]:Running queries")
#run_queries(list_query_files_name,list_query_files_name_rep)
run_final_queries(final_queries)