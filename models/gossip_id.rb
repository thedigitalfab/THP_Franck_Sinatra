require 'csv'

class Gossip
    attr_accessor :author, :content, :id
    @@id = 0
  
    def initialize (id, author, content)
        @author = author
        @content = content
        @id = @@id
        @@id += 1
    end
  
  
    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << ["#{@@id}", "#{@author}", "#{@content}"]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])
        end
        return all_gossips
    end

    def self.find(id)
        all_gossips = self.all
        puts all_gossips[id.to_i]
        return all_gossips[id.to_i]
    end
  
  end