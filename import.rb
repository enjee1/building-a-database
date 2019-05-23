require "pg"
require "csv"

def db_connection
  begin
    connection = PG.connect(dbname: "building_database")
    yield(connection)
  ensure
    connection.close
  end
end
