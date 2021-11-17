class SectionFinder
  def initialize(text_array)
    @text_array = text_array
  end

  def find_section(section_name)
    start_line = find_section_start(section_name)
    end_line = find_section_end(start_line)
    @text_array[start_line, end_line]
  end

  private

  def find_section_start(section_name)
    @text_array.find_index { |line| line.include?(section_name) }
  end

  def find_section_end(starting_index)
    partial = @text_array.slice(starting_index..)
    next_section_start = partial[1..].find_index { |line| line.include?('###') }
    next_section_start ? next_section_start : partial.length
  end
end
