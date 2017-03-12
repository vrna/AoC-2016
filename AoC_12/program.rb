# this is a comment, isn't it?
# sooo, initaliaze
inputfilename = ARGV[0]
instructions = IO.readlines(inputfilename)
index = 0
instr = instructions[index]
regs = Hash["a" => 0, "b" => 0, "c" => 0, "d" => 0]
if ARGV.size > 1
  regs["c"] = Integer(ARGV[1])
end
while !instr.empty?
  #puts instr
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
    regs[targetR] = Integer(value)
  elsif command == "inc"
    # inc x: increases register x
    regs[register] += 1
  elsif command == "dec"
    # dec x: decreases register x
    regs[register] -= 1
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
      step = Integer(arguments[2])
    end
  end
  #puts step
  index += step
  if index < instructions.size
    instr = instructions[index]
  else
    instr = ""
  end
  #puts regs
  #STDIN.gets
end
# should be 318083
puts "register a: " + regs["a"].to_s
