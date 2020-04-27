require 'csv'

class Gossip
    attr_accessor :author, :content
    
    def initialize (new_author, new_content)
        @author = new_author
        @content = new_content
    end
  
    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << ["#{@author}", "#{@content}"]
        end
    end

    def self.update(new_id,new_author,new_content)
        updated_object = Gossip.new("#{new_author}","#{new_content}")
        table = CSV.table("./db/gossip.csv", headers: false)
        table[new_id.to_i][0] = updated_object.author
        table[new_id.to_i][1] = updated_object.content
        CSV.open("./db/gossip.csv", "w") do |csv|
            table.each do |line|
                # csv << ["#{table_line[0]}", "#{table_line[1]}"]
                csv << line
            end
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id)
        # all_gossips = self.all
        return self.all[id.to_i]
    end
end