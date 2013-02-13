begin
	require "rubygems"
	require "hpricot"
	require "selenium-webdriver"
	require "watir-webdriver"
	require 'net/http'
	require 'uri'
	require 'socket'
	require 'date'
	require 'json'
	require 'net/smtp'
	require 'net/ssh'
	require 'net/scp'  
	require 'fileutils'
	require 'tlsmail'
	require 'date'
	require 'timeout'
rescue LoadError => error
	puts "Missing dependencies:"
	raise error
end

def getFilePath(klassName)
  path = klassName.split('_').collect! do |name|
    name.split(/(?=[A-Z])/).join('_')
  end
  s = File::SEPARATOR
  if $settings and path.include?('Tests')
    return $settings.root_folder_path + s + path.join(s).downcase
  end
  return File.expand_path( File.dirname(__FILE__) ) + s + path.join(s).downcase
end

class Object
  
  class Array
    def shuffle
      sort_by { rand }
    end
  end

  class << self
  
    def self.readable_attribute(name)
      code = %Q{
                def #{name}
                  @#{name}
                end
                }
      class_eval(code)
    end  
    
    alias_method :old_const_missing, :const_missing
    private :old_const_missing
    def const_missing(const)
      filename = getFilePath(const.to_s)
      begin
        if File.exists?("#{filename}.rb")
          require filename
        else
          raise "FileNotFound"
        end
        const_get(const)
      rescue LoadError => e
        if e.message.include? filename
          old_const_missing(const)
        else
          raise e
        end
      end
    end
  end
end

def createDirectory(path)
      pathArray = path.split('/')
      if(pathArray.empty?)
        return false
      end
      child = pathArray.pop
      parent = pathArray.join('/')
      if(parent.empty?)
        return false
      end
    if(!File.exists?(parent))
      create = createDirectory(parent)
      if(create)
        Dir.mkdir(parent)
      else
        return false
      end
    end
    return true
end

def subclasses_of(superclass)
  subclasses = []
  ObjectSpace.each_object(Class) do |k|
    next if !k.ancestors.include?(superclass) || superclass == k || k.to_s.include?('::') || subclasses.include?(k.to_s)
    subclasses << k.to_s
  end
  subclasses
end