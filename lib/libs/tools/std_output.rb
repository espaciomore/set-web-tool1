class Libs_Tools_StdOutput 
  def testReport(reason, condition)
    begin
      $stderr.puts("#{reason} #{condition}")
    rescue
      puts :CouldNotWriteToStdOut
    end
  end
end