class Board
    def initialize()
        @cells = {1=>"1", 2=>"2", 3=>"3", 4=>"4", 5=>"5", 6=>"6", 7=>"7", 8=>"8", 9=>"9"}
    end

    def display()
        puts "#{@cells[1]} | #{@cells[2]} | #{@cells[3]}"
        puts "#{@cells[4]} | #{@cells[5]} | #{@cells[6]}"
        puts "#{@cells[7]} | #{@cells[8]} | #{@cells[9]}"
    end

    def mark(cell, marker)
        @cells[cell.to_i] = marker if checkValid(cell)
    end

    def checkWin()
        if @cells[1] == @cells[2] && @cells[2] == @cells[3] 
            endGame(@cells[1])
            return true
        elsif @cells[4] == @cells[5] && @cells[5] == @cells[6]
            endGame(@cells[4])
            return true
        elsif @cells[7] == @cells[8] && @cells[9] == @cells[8]
            endGame(@cells[7])
            return true
        elsif @cells[1] == @cells[4] && @cells[4] == @cells[7]
            endGame(@cells[4])
            return true
        elsif @cells[8] == @cells[5] && @cells[5] == @cells[2]
            endGame(@cells[5])
            return true
        elsif @cells[3] == @cells[6] && @cells[9] == @cells[6]
            endGame(@cells[3])
            return true
        elsif @cells[1] == @cells[5] && @cells[5] == @cells[9]
            endGame(@cells[5])
            return true
        elsif @cells[3] == @cells[5] && @cells[5] == @cells[7]
            endGame(@cells[3]) 
            return true
        else
            return false
        end
    end

    def checkValid(cell)
        if @cells[cell.to_i] == cell
            return true
        else 
            puts "Invalid. That cell is already checked!"
            return false
        end
    end

    def endGame(marker)
        puts "#{Player.info(marker)} win"
        return true
    end

    def checkFull()
        for i in 1..9
            return false if @cells[i] == i.to_s
        end
        puts "Draw!!!"
        return true
    end
end

class Player
    @@info = {}
    attr_reader :name     
    attr_reader :marker
    def initialize(name, marker)
        @name = name
        @marker = marker
        @@info[@marker] = @name
    end
    def self.info(marker)
        @@info[marker]
    end

    def self.refresh
        @@info = {}
    end
    
end

loop do
    Player.refresh
    board = Board.new
    puts "Pick player1's name: "
    name1 = gets.chomp
    marker1 = 'x'
    player1 = Player.new(name1, marker1)

    puts "Pick player2's name: "
    name2 = gets.chomp
    marker2 = 'o'
    player2 = Player.new(name2, marker2)

    board.display
    turn = 1
    while !board.checkWin() do
        break if board.checkFull
        if turn % 2 == 1
            puts "#{player1.name} turn: enter index of cell:"
            cell1 = gets.chomp
            while !board.checkValid(cell1) do
                cell1 = gets.chomp
            end
            board.mark(cell1, player1.marker)
            board.display
            
        else 
            puts "#{player2.name} turn: enter index of cell:"
            cell2 = gets.chomp
            while !board.checkValid(cell2) do
                cell2 = gets.chomp
            end
            board.mark(cell2, player2.marker)
            board.display
        end
        turn += 1


    end 

    puts "Do you want to play again? (y/n)"
    play = gets.chomp
    break if play == "n" || play == "n"

end