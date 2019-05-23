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

csv_records = CSV.readlines("data.csv", headers: true)

zoning_types = csv_records.map { |record| record["zoning_type"]}.uniq
zoning_types.each do |type|
  sql = "INSERT INTO zoning_types (name) VALUES ($1)"
  db_connection do |conn|
    require "pry"
    binding.pry
    conn.exec_params(sql, [type])
  end
end

construction_types = csv_records.map { |record| record["construction_type"]}.uniq
construction_types.each do |type|
  sql = "INSERT INTO construction_types (name) VALUES ($1)"
  db_connection do |conn|
    conn.exec_params(sql, [type])
  end
end
