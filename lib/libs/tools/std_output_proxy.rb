class Libs_Tools_StdOutputProxy
  def initialize()
    @stdOutput = Libs_Tools_StdOutput.new
  end
  
  def testReport(reason, condition)
    if $_usingStdOutput
      @stdOutput.testReport(reason, condition)
    end
  end
end