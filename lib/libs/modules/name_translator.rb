module Libs_Modules_NameTranslator
  def worm_case(str)
    str.split(/(?=[A-Z])/).map{|w| w.downcase }.join("_")
  end
  
  def explode_class_name(str)  
    str.split('_').collect{ |w| w = worm_case(w); }
  end
end