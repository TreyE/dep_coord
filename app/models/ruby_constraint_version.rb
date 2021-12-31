class RubyConstraintVersion
  attr_reader :min_version, :max_version

  def initialize(min_v, max_v)
    if min_v == "000000.000000.000000"
      @min_version = nil
    else
      @min_version = min_v
    end
    @max_version = max_v
  end

  def self.from_constraint_string(version_string)
    return nil if version_string.index(",")
    first_number = version_string.index(/[0-9]/)
    return nil unless first_number
    comparator = version_string.slice(0, first_number).strip
    numbers = version_string.slice(first_number,version_string.length).strip
    case comparator
    when "~>"
      components = numbers.split(".").map(&:strip)
      case components.length
      when 2
        min = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.000000"
        max = "#{components[0].rjust(6,"0")}.999999.999999"
        self.new(min, max)
      else
        min = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.#{components[2].rjust(6,"0")}"
        max = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.999999"
        self.new(min, max)
      end
    when ">="
      components = numbers.split(".").map(&:strip)
      case components.length
      when 2
        min = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.000000"
        self.new(min,nil)
      when 1
        min = "#{components[0].rjust(6,"0")}.000000.000000"
        self.new(min,nil)
      else
        min = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.#{components[2].rjust(6,"0")}"
        self.new(min,nil)
      end
    when "<="
      components = numbers.split(".").map(&:strip)
      case components.length
      when 2
        max = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.000000"
        self.new(nil,max)
      when 1
        max = "#{components[0].rjust(6,"0")}.000000.000000"
        self.new(nil,max)
      else
        max = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.#{components[2].rjust(6,"0")}"
        self.new(nil,max)
      end
    when ">"
      components = numbers.split(".").map(&:strip)
      case components.length
      when 2
        max_val = (components[1].to_i + 1).to_s.rjust(6,"0")
        min = "#{components[0].rjust(6,"0")}.#{max_val}.000000"
        self.new(min,nil)
      when 1
        max_val = (components[0].to_i + 1).to_s.rjust(6,"0")
        min = "#{max_val}.000000.000000"
        self.new(min,nil)
      else
        max_val = (components[2].to_i + 1).to_s.rjust(6,"0")
        min = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.#{max_val}"
        self.new(min,nil)
      end
    when "<"
      components = numbers.split(".").map(&:strip)
      case components.length
      when 2
        max_value_0 = components[0].rjust(6,"0")
        max_value_1 = (components[1].to_i - 1).to_s.rjust(6,"0")
        if (components[1].to_i == 0)
          max_value_0 = (components[0].to_i - 1).to_s.rjust(6,"0")
          max_value_1 = "999999"
        end
        max = "#{max_value_0}.#{max_value_1}.999999"
        self.new(nil,max)
      when 1
        max_value = (components[0].to_i - 1).to_s.rjust(6,"0")
        max = "#{max_value}.999999.999999"
        self.new(nil,max)
      else
        max_value_0 = components[0].rjust(6,"0")
        max_value_1 = components[1].rjust(6,"0")
        max_value_2 = (components[2].to_i - 1).to_s.rjust(6,"0")
        if (components[1].to_i == 0) && (components[2].to_i == 0)
          max_value_0 = (components[0].to_i - 1).to_s.rjust(6,"0")
          max_value_1 = "999999"
          max_value_2 = "999999"
        elsif (components[2].to_i == 0)
          max_value_1 = (components[1].to_i - 1).to_s.rjust(6,"0")
          max_value_2 = "999999"
        end
        max = "#{max_value_0}.#{max_value_1}.#{max_value_2}"
        self.new(nil,max)
      end
    else
      components = numbers.split(".").map(&:strip)
      case components.length
      when 2
        min = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.000000"
        max = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.999999"
        self.new(min, max)
      when 1
        min = "#{components[0].rjust(6,"0")}.000000.000000"
        max = "#{components[0].rjust(6,"0")}.999999.999999"
        self.new(min, max)
      else
        min = "#{components[0].rjust(6,"0")}.#{components[1].rjust(6,"0")}.#{components[2].rjust(6,"0")}"
        max = min
        self.new(min, max)
      end
    end
  end

  def self.stored_string_to_version_string(version_string)
    return nil if version_string.blank?
    components = version_string.split(".")
    if (components[2] == "999999") && (components[1] == "999999")
      "< #{(components[0].to_i + 1).to_s}.0.0"
    elsif (components[2] == "999999")
      "< #{components[0].to_i}.#{(components[1].to_i + 1).to_s}.0"
    else
      components.map(&:strip).map(&:to_i).map(&:to_s).join(".")
    end
  end
end