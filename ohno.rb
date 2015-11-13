$LOAD_PATH << '.'

# Global Definitions
$debug = true
$verbose = true
$RED = "\x1b[37;41m "
$BLUE = "\x1b[37;44m"
$EMPTY = "\x1b[0m-"
$NORMAL = "\x1b[0m"

def verbose(text)
  print(text) if $verbose 
end

def debug(text)
  print(text) if $debug 
end

class Node
  @color
  @numbered
  @number
  @complete
  def initialize(color, numbered, number, complete)
    @color = color
    @numbered = numbered
    @number = number
    @complete = complete
  end
  def to_s
    case @color
    when "Blue"
      if @numbered
        return number
      else
        return "B"
      end
    when "Red"
      return "x"
    when "Empty"
      return "-"
    end
      
  end
  def color
    @color
  end
  def numbered
    @numbered
  end
  def number
    @number
  end
  def complete
    @complete
  end
end

def colorize(t)
  return t  # add colorization logic
end

def showboard(board)
  text = ""
  board.each do |row|    
    row.each do |node| 
      text +=  node.to_s
    end
    text += "\n"
    if STDOUT.isatty
      text = colorize(text)
    end
  end  
  return text
end

# Look for an incomplete Numbered Dot.
# Can it see all its dots? 
#    If so, add a red terminus at first Empty node in row and column, mark Node Complete
# If flipping the first Empty Node to Blue makes it see too many, than that Node is Red
# Generate possible solutions in all directions, save each in an array of cell coordinates
# If only one solution exists, use it. Set terminus Nodes to Red, mark Node as Complete
# otherwise, Look for overlap in the solutions (array intersections) - Flip those to blue
# If all numbered Nodes are Complete, fill in remaining Empty Nodes as Red

def doMoves(board)
  moreMoves = true
  pass = 1
  while moreMoves 
    changed = false
    debug("\nRow Pass: #{pass}\n")
    for row in 0..board.length-1
      for col in 0..board.length-1
        if board[row][col].numbered && !board[row][col].complete
          # Start working it right here
        end
      end
    end   # Row pass complete

    if !changed
      moreMoves = false
      # fill in empties with Red
    end
    break
    
  end
  return board
end

fname = ARGV[0]
if fname == ""
  fname = "ohnoBoard1.txt"
end

board = Array.new
file = File.open(fname).readlines.each do |line|
  line.chomp!
  row = Array.new
  line.split("").each do |c|
    #n = (Node.new("Blue", true, c, false)) if c.is_a?(Integer)
    case c
    when "x"
      n = Node.new("Red", false, 0, true)
    when "-"
      n = Node.new("Empty", false, 0, false)
    else
      n = Node.new("Blue", true, c, false)
    end
    row.push(n)
  end  
  board.push(row)
end

verbose("Board Size: #{board.length} x #{board.length}\n")

verbose("Initial board\n" + showboard(board))

board = doMoves(board)

#verbose("Solved!\n")

#print(showboard(board))
