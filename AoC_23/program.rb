# this is a comment, isn't it?
# sooo, initaliaze
inputfilename = "real.in"
instructions = IO.readlines(inputfilename)
debug = FALSE
index = 0
instr = instructions[index]
regs = Hash["a" => 0, "b" => 0, "c" => 0, "d" => 0]
#if ARGV.size > 1
regs["a"] = 7
#end
phase = 0
try = 67135
while !instr.empty?
  phase += 1
  if debug
    puts instr
  end
  step = 1
  arguments = instr.split(" ")
  command = arguments[0]
  register = arguments[1]
  # cpy x y: x either a register or a nr
  if command == "cpy"
    sourceR = arguments[1]
    targetR = arguments[2]
    value = nil
    # check the sourceR
    if sourceR.match("[0-9]+")
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
    if !register.match("[0-9]+")
      val = Integer(regs[register])
    else
      val = Integer(register)
    end
    #puts "jump " + arguments[2] + " if " + val.to_s + " is not 0"
    if val != 0
      if !register.match("[0-9]+")
        step = Integer(arguments[2])
      else
        step = Integer(regs[arguments[2]])
      end
    end
  elsif command == "tgl"
  # if outside, nothing happens
    val = index
    if !register.match("[0-9]+")
      val += Integer(regs[register])
    else
      val += Integer(register)
    end

    if val < instructions.size
      # toggle command x (register) away
      # one-argument: inc --> dec, other --> inc
      # two-argument: jnz --> cpy, other --> jnz
      # if argument becomes invalid, skip
      toggledLine = instructions[val]
      if debug
        puts "toggling: " + toggledLine
      end

      toggledCommand = toggledLine.split(" ")[0]
      argumentcount = toggledLine.split(" ").size
      if toggledCommand == "inc"
        toggledLine = toggledLine.gsub("inc","dec")
      elsif toggledCommand == "jnz"
        toggledLine = toggledLine.gsub("jnz","cpy")
      elsif argumentcount == 2
        toggledLine = toggledLine.sub(/^.../, 'inc')
      elsif argumentcount == 3
        toggledLine = toggledLine.sub(/^.../, 'jnz')
      end
      instructions[val] = toggledLine
      if debug
        puts "toggled to: " + toggledLine
      end
    end
  end
  #puts step
  index += step
  if index < instructions.size
    instr = instructions[index]
  else
    instr = ""
  end

  if debug
    puts regs
    STDIN.gets
  else
    puts phase.to_s + ": " + regs.to_s
  end

end
# should be 318083 in part 1
# should be 9227737 in part 2
puts "register a: " + regs["a"].to_s
