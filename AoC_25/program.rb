# this is a comment, isn't it?
# sooo, initaliaze
#a: 6  -> 6810 0.10
#a: 7  -> 11130 0.25
#a: 8  -> 46410 1.67
#a: 9  -> 368970 12.20
#a: 10 -> 3634890 122.71
start = Time.now
inputfilename = "input.txt"
instructions = IO.readlines(inputfilename)

a_value = 0

foundValid = false
MAX_READS = 1000

while !foundValid
  a_value = a_value + 1
  # initalize
  regs = Hash["a" => 0, "b" => 0, "c" => 0, "d" => 0]
  regs["a"] = a_value
  index = 0
  instr = instructions[index]
  output = ""
  previousoutput = ""
  reads = 0
  invalid = false

  puts "trying with: " + a_value.to_s

  # read until instr empty, reached 1000 valid sequence or found invalid
  while !instr.empty? and reads < MAX_READS and !foundValid and !invalid
    #puts (a_value.to_s + ": " + instr)
    step = 1
    arguments = instr.split(" ")
    command = arguments[0]
    register = arguments[1]
    if command == "cpy"
      sourceR = arguments[1]
      targetR = arguments[2]
      value = nil
      # check the sourceR
      if sourceR.match("-?[0-9]+")
        value = sourceR
      else
        value = regs[sourceR]
      end
      if(targetR.match("[a-zA-Z]+"))
        regs[targetR] = Integer(value)
      end
    elsif command == "inc"
      # inc x: increases register x
      regs[register] += 1
    elsif command == "dec"
      # dec x: decreases register x
      #if phase > 67140
      #  puts regs[register]
      #  puts regs[register] - 1
      #end
      regs[register] = regs[register] - 1
    elsif command == "jnz"
      # jnz x y: jumps y steps if register x not zero
      val = 0
      if !register.match("-?[0-9]+")
        val = Integer(regs[register])
      else
        val = Integer(register)
      end
      #puts "jump " + arguments[2] + " if " + val.to_s + " is not 0"
      if val != 0
        if arguments[2].match("-?[0-9]+")
          step = Integer(arguments[2])
        else
          step = Integer(regs[arguments[2]])
        end
      end
    elsif command == "out"
      if !register.match("-?[0-9]+")
        val += Integer(regs[register])
      else
        val += Integer(register)
      end
      #puts val
      previousoutput = output
      output = val.to_s
      reads += 1
      #puts reads
      if (output == "1" and previousoutput == "0") or (output == "0" and previousoutput == "1")
        #puts "(" + previousoutput + ","+ output +")"
        #puts (a_value.to_s + ": ok")
        if reads >= MAX_READS
          foundValid = true
        end
      elsif previousoutput != "" and output != ""
        #puts "(" + previousoutput + ","+ output +")"
        #puts (a_value.to_s + ": invalid")
        puts "invalid after " + reads.to_s + " reads"
        invalid = true
      end
    end
    #puts step
    index += step
    if index < instructions.size
      instr = instructions[index]
    else
      instr = ""
    end


  end
end
# should be 318083 in part 1
# should be 9227737 in part 2
if foundValid
  puts "Found repeating sequence when a was set to " + a_value.to_s
end
puts "register a: " + regs["a"].to_s
finish = Time.now
puts (finish - start).to_s
