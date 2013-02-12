class Lib_Tools
  attr_accessor :watir_helper
  
  def initialize(test_object)
    @ATest = test_object
    @watir_helper = Lib_Tools_WatirHelper.new(self) 
  end
    
  def browser
    @ATest.browser   
  end
  
  def report
    @ATest.report
  end  

  def give_me_word(length=2)
    if length<0
      length.abs
    end   
    string = ""
    chars = ("a".."z").to_a
    length.times do
      string << chars[rand(chars.length-1)]
    end
    string
  end
  
  def including? first,second
    if second.kind_of?(Array)
      second.each do |recursive_second|
        if including?(first, recursive_second)
          return true
        end
      end
    else
      return first.include?(second)
    end
  end

  def update_report(description, reason)
    _reason = report.overallResult=='PASSED' ? reason : 'CRASHED'
    if _reason.instance_of?(Proc) # => Proc === _reason
      update_report(description, _reason.call) 
    else
      report.addToReport(description, _reason)  
    end    
  end 
  
end