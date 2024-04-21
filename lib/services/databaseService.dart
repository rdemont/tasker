import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt ;
import 'dart:convert' as convert;
import 'dart:developer';

class DatabaseService {
  static const String databaseName = "taskerdb.sqlite";
  static Database? db;

  static const DATABASE_VERSION = 1;
  

  static const SECRET_KEY = "2021_PRIVATE_KEY_ENCRYPT_2021";

  static Future<Database> initializeDb() async {
    final databasePath = (await getApplicationDocumentsDirectory()).path;
    final path = join(databasePath, databaseName);
    print(path);
    return db ??
        await openDatabase(
          path,
          version: DATABASE_VERSION,
          onCreate: (Database db, int version) async {
            await createTables(db);
          },
          onUpgrade: (db, oldVersion, newVersion) async {
            await updateTables(db, oldVersion, newVersion);
          },
          onOpen: (db) async {
            await openDB(db);
          },
        );
  }

  static Future<void> emptyTables()
  {
    print("** empty tables **");
    return DatabaseService.initializeDb().then((db){
      return db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;').then((tables) 
      {
        if (tables.length > 0) 
        {
          for (int i = 0; i < tables.length; i++) 
          {

            String tableName = tables[i]['name'].toString() ; 
            if ((tableName != "sqlite_sequence") && (tableName != "android_metadata"))
            {
              db.execute("DELETE FROM '$tableName' ");
            }
          }
        }
      });
    });
  }

  static openDB(Database db) async {
    //db.execute("UPDATE Todo SET groupId = 0 WHERE groupId IS NULL");
    
    /*
    print("** Drop table **"); 
    await db.execute("DROP TABLE IF EXISTS task");
    await db.execute("DROP TABLE IF EXISTS taskGroup");
    await db.execute("DROP TABLE IF EXISTS tag");
    await db.execute("DROP TABLE IF EXISTS tagTask");

    //db.execute("DELETE FROM  task");
    //db.execute("DELETE FROM  taskGroup");

    print("** create table **"); 
    await createTables(db);
    */


    print("** show tables **");
    db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;').then((tables) 
    {
      if (tables.length > 0) 
      {
        String strjson = "{\"tables\":[" ; 
        for (int i = 0; i < tables.length; i++) 
        {

          String tableName = tables[i]['name'].toString() ; 
          if ((tableName != "sqlite_sequence") && (tableName != "android_metadata"))
          {
            db.rawQuery("PRAGMA table_info('$tableName')").then((cols)
            {
              db.rawQuery("SELECT count(*) as nb FROM $tableName").then((count)
              {
                  db.rawQuery("SELECT * FROM $tableName ORDER BY ID ").then((raws){
                  print("TABLE : $tableName / NB-Raw : "+count[0]['nb'].toString());          
                  print(tables[i]);
                  for (int iraw = 0 ; iraw<raws.length;iraw++)
                  {
                    print(raws[iraw]);
                  }

                  
                });

              });

              strjson += "{\"$tableName\":[";
              for(int icol = 0;icol < cols.length;icol++)
              {
                String colName = cols[icol]['name'].toString();
                String colType = cols[icol]['type'].toString();
                String colpk = cols[icol]['pk'].toString();
                String colNotnull = cols[icol]['notnull'].toString();
               
                strjson += "{\"name\":\"$colName\",\"type\":\"$colType\",\"ispk\":\"$colpk\",\"notnull\":\"$colNotnull\"},";
              }
              strjson = strjson.substring(0,strjson.length-1)+"]},";


              if (i == tables.length-1)
              {
                strjson = strjson.substring(0,strjson.length-1)+"]}";
                print("*********************JSON STRUCTURE ******************************");
                log(strjson);
                print("*********************END JSON STRUCTURE ******************************");
              }
            });
          }
        }
        
      }
    });
  
  }

  static updateTables(Database db, int oldVersion, int newVersion) {
    print(" DB Version : $newVersion");
    db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;').then((value) {
      print(value);
    });


    if (oldVersion < newVersion) {
      if (oldVersion < 2) // add group table with link on todo
      {
        /*
        db.execute("""
              CREATE TABLE Groups(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL
              )      
            """);
        db.execute("""ALTER TABLE Todos ADD COLUMN group_FK INT """);
        */
      }
    }
  }

  static Future<void> createTables(Database database) async {
    
    await database.execute("""
      CREATE TABLE IF NOT EXISTS task(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskGroupId int NOT NULL,          
          name TEXT NOT NULL,
          description TEXT,
          isDone BOOLEAN,
          insertTime DATETIME DEFAULT CURRENT_TIMESTAMP, 
          updateTime DATETIME DEFAULT CURRENT_TIMESTAMP  
      )      
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS taskGroup(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        insertTime DATETIME DEFAULT CURRENT_TIMESTAMP,
        updateTime DATETIME DEFAULT CURRENT_TIMESTAMP  
      )          
    """);


    await database.execute("""
      CREATE TABLE IF NOT EXISTS tag(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        insertTime DATETIME DEFAULT CURRENT_TIMESTAMP,
        updateTime DATETIME DEFAULT CURRENT_TIMESTAMP  
      )          
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS tagTask(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tagId INTEGER NOT NULL,
        taskId INTEGER NOT NULL
      )          
    """);

    //await database.insert('Groups', Group(name: "Default").toMap());

  }


    static Future<String> generateBackup({bool isEncrypted = false}) async {

    print('GENERATE BACKUP');
   
    var dbs = await DatabaseService.initializeDb();

    List data =[];
    List<String> tables =[];
    
    List<Map<String,dynamic>> listMaps=[];

    for (var i = 0; i < tables.length; i++)
    {

      listMaps = await dbs.query(tables[i]); 

      data.add(listMaps);

    }

    List backups=[tables,data];

    String json = convert.jsonEncode(backups);

    if(isEncrypted)
    {

      var key = encrypt.Key.fromUtf8(SECRET_KEY);
      var iv = encrypt.IV.fromLength(16);
      var encrypter = encrypt.Encrypter(encrypt.AES(key));
      var encrypted = encrypter.encrypt(json, iv: iv);
        
      return encrypted.base64;  
    }
    else
    {
      return json;
    }
  }

  static Future<void>restoreBackup(String backup,{ bool isEncrypted = false}) async {

    await DatabaseService.emptyTables();

    var dbs = await DatabaseService.initializeDb();
    


    Batch batch = dbs.batch();
    
    var key = encrypt.Key.fromUtf8(SECRET_KEY);
    var iv = encrypt.IV.fromLength(16);
    var encrypter = encrypt.Encrypter(encrypt.AES(key));

    List json = convert.jsonDecode(isEncrypted ? encrypter.decrypt64(backup,iv:iv):backup);

    for (var i = 0; i < json[0].length; i++)
    {
      for (var k = 0; k < json[1][i].length; k++)
      {
        batch.insert(json[0][i],json[1][i][k]);
      }
    }

    await batch.commit(continueOnError:false,noResult:true);

    print('RESTORE BACKUP');
  }

}

