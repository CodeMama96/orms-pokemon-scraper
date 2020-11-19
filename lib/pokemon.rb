class Pokemon
    attr_accessor :id, :name, :type, :db, :hp
    def initialize(id:, name:, type:, db:, hp: nil)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
    end

    def self.save(name, type, db)
        sql = <<-SQL
          INSERT INTO pokemon (name, type)
          VALUES (?,?)
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)

        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?;
        SQL
        result = db.execute(sql, id).flatten
            Pokemon.new(id: result[0],name: result[1],type: result[2], db: db, hp: result[3])
        # db.execute(sql, id, db)
    end

    def alter_hp(new_hp, db)
        db.execute("UPDATE pokemon SET hp = ?;", new_hp, self.id)
    end
end
